import 'package:flutter/material.dart';
import 'package:sendspace/theme/dark_theme.dart';
import 'package:sendspace/theme/light_theme.dart';

class AppTheme {
  // Base theme shared between light and dark
  static ThemeData baseTheme(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      highlightColor: Colors.transparent,
      colorScheme: scheme,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // slightly rounder
          ),
          elevation: 0, // remove shadow for a flatter look
          shadowColor: Colors.transparent, // just in case
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: scheme.primary),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100, // background for text fields
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        labelStyle: TextStyle(color: Colors.grey.shade700, fontSize: 14),
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.secondary, width: 2),
        ),
      ),
    );
  }

  static ColorScheme get light => lightColorScheme;
  static ColorScheme get dark => darkColorScheme;
}
