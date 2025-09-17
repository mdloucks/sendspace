import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sendspace/theme/text_theme.dart';

extension ThemeModeExtension on BuildContext {
  bool get isDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension FontModifier on TextTheme {
  TextTheme permanentMarker() {
    return applyFontToTextTheme(this, GoogleFonts.permanentMarker);
  }
}
