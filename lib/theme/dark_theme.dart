import 'package:flutter/material.dart';
import 'text_theme.dart';
import 'app_colors.dart';

final ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.darkPrimary,
  colorScheme: ColorScheme.dark(
    primary: AppColors.darkPrimary,
    secondary: AppColors.darkSecondary,
    tertiary: AppColors.accent,
    onPrimary: Colors.black,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkText,
  ),
  scaffoldBackgroundColor: AppColors.darkBackground,
  textTheme: appTextTheme.apply(
    bodyColor: AppColors.darkText,
    displayColor: AppColors.darkText,
  ),
);
