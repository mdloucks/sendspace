import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sendspace/core/extensions/build_context.dart';
import 'package:sendspace/theme/color_schemes.dart';
import 'package:sendspace/theme/text_theme.dart';

class AppTheme {
  static ColorScheme get dark => darkColorScheme;

  static ColorScheme get light => lightColorScheme;
  // Base theme shared between light and dark
  static ThemeData baseTheme(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      highlightColor: Colors.transparent,
      colorScheme: scheme,
      textTheme: buildAppTextTheme(scheme),

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

      inputDecorationTheme: buildInputDecorationTheme(
        scheme,
        buildAppTextTheme(scheme),
      ),
    );
  }
}

InputDecorationTheme buildInputDecorationTheme(
  ColorScheme scheme,
  TextTheme textTheme,
) {
  final bool isDark = scheme.brightness == Brightness.dark;

  return InputDecorationTheme(
    filled: true,
    fillColor:
        isDark
            ? scheme.surfaceContainerHighest
            : scheme.surface, // subtle background for dark mode
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    labelStyle: textTheme.bodyMedium?.copyWith(
      color: isDark ? scheme.onSurfaceVariant : scheme.onSurfaceVariant,
      fontSize: 14,
    ),
    hintStyle: textTheme.bodyMedium?.copyWith(
      color:
          isDark
              ? scheme.onSurfaceVariant.withOpacity(0.7)
              : scheme.onSurfaceVariant.withOpacity(0.7),
      fontSize: 14,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: isDark ? scheme.surfaceContainerHighest : scheme.outline,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: isDark ? scheme.surfaceContainerHighest : scheme.outline,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: scheme.secondary, width: 2),
    ),
  );
}
