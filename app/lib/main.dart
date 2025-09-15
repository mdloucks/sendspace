import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendspace/core/application/auth_state.codegen.dart';
import 'package:sendspace/core/extensions/build_context.dart';
import 'package:sendspace/routes/app_routes.dart';
import 'package:sendspace/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // TODO: Make a build conf for this that lets you switch between
  // prod and local envs
  // prod
  //await Supabase.initialize(
  //  url: 'https://rbymhfojoxmivcekwwer.supabase.co',
  //  anonKey:
  //      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJieW1oZm9qb3htaXZjZWt3d2VyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUyMDAwMTIsImV4cCI6MjA2MDc3NjAxMn0.jyFm4DBbP_gFfSEPSxoXVUZtX3vRONbOh_KNWDo01lw',
  //);
  await dotenv.load(); // Defaults to loading ".env" from project root

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const ProviderScope(child: SendSpaceApp()));
}

class SendSpaceApp extends ConsumerWidget {
  const SendSpaceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // read is intentional here, since we only want to load this once, and handle
    // navigation inside the auth page
    final userId = ref.read(authStateNotifierProvider).userId;
    final initialPath = userId.maybeWhen(
      data: (id) => id != null ? AppRoute.home : AppRoute.auth,
      orElse: () => AppRoute.auth,
    );
    return MaterialApp.router(
      routerConfig: getAppRouter(initialPath),
      title: 'SendSpace',
      theme: AppTheme.baseTheme(
        context.isDarkMode ? AppTheme.dark : AppTheme.light,
      ),
    );
  }
}

// Custom extension to show snackbars with error or success messages
extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError
                ? Theme.of(this).colorScheme.error
                : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}
