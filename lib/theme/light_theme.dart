import 'package:flutter/material.dart';
import 'package:sendspace/theme/app_colors.dart';
import 'text_theme.dart';

final ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    tertiary: AppColors.accent,
    onPrimary: Colors.white,
    surface: AppColors.surface,
    onSurface: AppColors.text,
  ),
  scaffoldBackgroundColor: AppColors.background,
  textTheme: appTextTheme,
);
