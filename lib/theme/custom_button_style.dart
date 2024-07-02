import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillAmber => ElevatedButton.styleFrom(
        backgroundColor: appTheme.amber600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
      );
// text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );

        static ButtonStyle get outlineBlueGrayC => ElevatedButton.styleFrom(
        backgroundColor: appTheme.amber600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(27.h),
        ),
        shadowColor: appTheme.blueGray3000c,
        elevation: 26,
      );
}
