import 'package:flutter/material.dart';
import 'package:sendspace/theme/dark_theme.dart';
import 'package:sendspace/theme/light_theme.dart';

class AppTheme {
  // Base theme shared between light and dark
  static ThemeData get baseTheme {
    return ThemeData(useMaterial3: true, highlightColor: Colors.transparent);
  }

  static ThemeData get light => lightThemeData;
  static ThemeData get dark => darkThemeData;
}
