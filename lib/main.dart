import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendspace/core/extensions/build_context.dart';
import 'package:sendspace/features/auth_page.dart';
import 'package:sendspace/features/home/dashboard.dart';
import 'package:sendspace/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://rbymhfojoxmivcekwwer.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJieW1oZm9qb3htaXZjZWt3d2VyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUyMDAwMTIsImV4cCI6MjA2MDc3NjAxMn0.jyFm4DBbP_gFfSEPSxoXVUZtX3vRONbOh_KNWDo01lw',
  );

  runApp(const ProviderScope(child: MyApp()));
}

final supabase =
    Supabase.instance.client; // Global Supabase client for easy access

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SendSpace',
      theme: context.isDarkMode ? AppTheme.dark : AppTheme.light,
      home:
          supabase.auth.currentSession == null
              ? const AuthPage()
              : const Home(), // Decide between AuthPage or Home based on session
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
