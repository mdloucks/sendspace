import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendspace/core/extensions/build_context.dart';
import 'package:sendspace/routes/app_routes.dart';
import 'package:sendspace/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // local

  await Supabase.initialize(
    url: 'http://127.0.0.1:54321',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
  );
  // prod
  //await Supabase.initialize(
  //  url: 'https://rbymhfojoxmivcekwwer.supabase.co',
  //  anonKey:
  //      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJieW1oZm9qb3htaXZjZWt3d2VyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUyMDAwMTIsImV4cCI6MjA2MDc3NjAxMn0.jyFm4DBbP_gFfSEPSxoXVUZtX3vRONbOh_KNWDo01lw',
  //);

  runApp(const ProviderScope(child: SendSpaceApp()));
}

class SendSpaceApp extends StatelessWidget {
  const SendSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'SendSpace',
      theme: context.isDarkMode ? AppTheme.dark : AppTheme.light,
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
