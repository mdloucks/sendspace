import 'package:flutter/widgets.dart';

class Spacing {
  // Small spacing (2 - 8 pixels)
  static const double xs = 4.0;
  static const double sm = 8.0;

  // Medium spacing (10 - 16 pixels)
  static const double md = 12.0;
  static const double lg = 16.0;

  // Large spacing (18 - 24 pixels)
  static const double xl = 20.0;
  static const double xxl = 24.0;

  // Huge spacing (28 pixels and above)
  static const double xxxl = 32.0;

  // Padding helpers
  static const EdgeInsets allSmall = EdgeInsets.all(sm);
  static const EdgeInsets allMedium = EdgeInsets.all(md);
  static const EdgeInsets allLarge = EdgeInsets.all(lg);

  static const EdgeInsets horizontalSmall = EdgeInsets.symmetric(
    horizontal: sm,
  );
  static const EdgeInsets horizontalMedium = EdgeInsets.symmetric(
    horizontal: md,
  );
  static const EdgeInsets horizontalLarge = EdgeInsets.symmetric(
    horizontal: lg,
  );

  static const EdgeInsets verticalSmall = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMedium = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets verticalLarge = EdgeInsets.symmetric(vertical: lg);
}
