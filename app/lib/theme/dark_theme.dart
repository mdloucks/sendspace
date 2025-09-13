import 'package:flutter/material.dart';
import 'package:sendspace/theme/app_theme.dart';
import 'text_theme.dart';
import 'app_colors.dart';

final ThemeData darkThemeData = AppTheme.baseTheme.copyWith(
  brightness: Brightness.dark,
  primaryColor: AppColors.darkPrimary,
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkOnPrimary,
    secondary: AppColors.darkSecondary,
    onSecondary: AppColors.darkOnSecondary,
    surface: AppColors.darkSurface,
    surfaceDim: AppColors.surfaceDim,
    onSurface: AppColors.darkOnSurface,
    error: AppColors.darkError,
    onError: Colors.black,
  ),
  dividerColor: AppColors.darkDivider,
  disabledColor: AppColors.darkDisabled,
  hintColor: AppColors.darkHint,
  scaffoldBackgroundColor: AppColors.darkBackground,
  textTheme: appDarkTextTheme,
);
