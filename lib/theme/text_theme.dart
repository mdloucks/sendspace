import 'package:flutter/material.dart';

import 'app_colors.dart';

final TextTheme appTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  ),
  titleLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  ),
  bodyMedium: TextStyle(fontSize: 16, color: AppColors.text),
  bodySmall: TextStyle(fontSize: 14, color: AppColors.mutedGray),
);
