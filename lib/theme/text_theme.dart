import 'package:flutter/material.dart';

import 'app_colors.dart';

final TextTheme appBaseTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  ),
  displayMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  ),
  displaySmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  ),
  headlineLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  ),
  headlineMedium: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  ),
  headlineSmall: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  ),
  titleLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.mutedGray,
  ),
  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.accent,
  ),
  labelMedium: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.accent,
  ),
  labelSmall: TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.accent,
  ),
);

final TextTheme appLightTextTheme = appBaseTextTheme.copyWith(
  displayLarge: appBaseTextTheme.displayLarge?.copyWith(color: AppColors.text),
  bodySmall: appBaseTextTheme.bodySmall?.copyWith(color: AppColors.mutedGray),
  labelLarge: appBaseTextTheme.labelLarge?.copyWith(color: AppColors.accent),
);

final TextTheme appDarkTextTheme = appBaseTextTheme.copyWith(
  displayLarge: appBaseTextTheme.displayLarge?.copyWith(
    color: AppColors.darkText,
  ),
  displayMedium: appBaseTextTheme.displayMedium?.copyWith(
    color: AppColors.darkText,
  ),
  displaySmall: appBaseTextTheme.displaySmall?.copyWith(
    color: AppColors.darkText,
  ),
  headlineLarge: appBaseTextTheme.headlineLarge?.copyWith(
    color: AppColors.darkText,
  ),
  headlineMedium: appBaseTextTheme.headlineMedium?.copyWith(
    color: AppColors.darkText,
  ),
  headlineSmall: appBaseTextTheme.headlineSmall?.copyWith(
    color: AppColors.darkText,
  ),
  titleLarge: appBaseTextTheme.titleLarge?.copyWith(color: AppColors.darkText),
  titleMedium: appBaseTextTheme.titleMedium?.copyWith(
    color: AppColors.darkText,
  ),
  titleSmall: appBaseTextTheme.titleSmall?.copyWith(color: AppColors.darkText),
  bodyLarge: appBaseTextTheme.bodyLarge?.copyWith(color: AppColors.darkText),
  bodyMedium: appBaseTextTheme.bodyMedium?.copyWith(color: AppColors.darkText),
  bodySmall: appBaseTextTheme.bodySmall?.copyWith(
    color: AppColors.darkMutedGray,
  ),
  labelLarge: appBaseTextTheme.labelLarge?.copyWith(
    color: AppColors.darkAccent,
  ),
  labelMedium: appBaseTextTheme.labelMedium?.copyWith(
    color: AppColors.darkAccent,
  ),
  labelSmall: appBaseTextTheme.labelSmall?.copyWith(
    color: AppColors.darkAccent,
  ),
);
