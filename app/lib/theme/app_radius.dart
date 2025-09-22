import 'package:flutter/material.dart';

class AppRadius {
  // Small radius (2 - 8 pixels)
  static const double xs = 4.0;
  static const double sm = 8.0;

  // Medium radius (10 - 16 pixels)
  static const double lg = 16.0;

  // Large radius (18 - 24 pixels)
  static const double xxl = 24.0;

  // Huge radius (28 pixels and above)
  static const double xxxl = 32.0;

  // BorderRadius helpers
  static const BorderRadius allXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius allSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius allLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius allXxl = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius allXxxl = BorderRadius.all(Radius.circular(xxxl));

  // Circular helpers for circles (useful for buttons, avatars, etc.)
  static const Radius circleXs = Radius.circular(xs);
  static const Radius circleSm = Radius.circular(sm);
  static const Radius circleLg = Radius.circular(lg);
  static const Radius circleXxl = Radius.circular(xxl);
  static const Radius circleXxxl = Radius.circular(xxxl);
}
