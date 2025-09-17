import 'package:flutter/material.dart';

TextTheme buildAppTextTheme(ColorScheme scheme) {
  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: scheme.onSurface,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: scheme.onSurface,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: scheme.onSurface,
    ),
    headlineLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: scheme.onSurface,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: scheme.onSurface,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: scheme.onSurface,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: scheme.onSurface,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: scheme.onSurface,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: scheme.onSurface,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: scheme.onSurface,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: scheme.onSurface,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: scheme.onSurfaceVariant,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: scheme.secondary,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: scheme.secondary,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: scheme.secondary,
    ),
  );
}

/// Applies a Google Font to every style in a given TextTheme.
/// [fontBuilder] is a function like `GoogleFonts.righteous`.
TextTheme applyFontToTextTheme(
  TextTheme base,
  TextStyle Function({TextStyle? textStyle}) fontBuilder,
) {
  return TextTheme(
    displayLarge: fontBuilder(textStyle: base.displayLarge),
    displayMedium: fontBuilder(textStyle: base.displayMedium),
    displaySmall: fontBuilder(textStyle: base.displaySmall),
    headlineLarge: fontBuilder(textStyle: base.headlineLarge),
    headlineMedium: fontBuilder(textStyle: base.headlineMedium),
    headlineSmall: fontBuilder(textStyle: base.headlineSmall),
    titleLarge: fontBuilder(textStyle: base.titleLarge),
    titleMedium: fontBuilder(textStyle: base.titleMedium),
    titleSmall: fontBuilder(textStyle: base.titleSmall),
    bodyLarge: fontBuilder(textStyle: base.bodyLarge),
    bodyMedium: fontBuilder(textStyle: base.bodyMedium),
    bodySmall: fontBuilder(textStyle: base.bodySmall),
    labelLarge: fontBuilder(textStyle: base.labelLarge),
    labelMedium: fontBuilder(textStyle: base.labelMedium),
    labelSmall: fontBuilder(textStyle: base.labelSmall),
  );
}
