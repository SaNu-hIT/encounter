import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray10001,
      );
  static BoxDecoration get fillGray50 => BoxDecoration(
        color: appTheme.gray50,
      );
// White decorations
  static BoxDecoration get white => BoxDecoration(
        color: appTheme.whiteA700,
      );
  static BoxDecoration get gradientTealToTeal300 => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0.5),
          end: Alignment(0.5, 1),
          colors: [appTheme.teal400, appTheme.teal300],
        ),
      );
  // Gradient decorations
  static BoxDecoration get gradientBlackToBlack => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.black900.withOpacity(0.30),
            appTheme.black900.withOpacity(0.30),
          ],
        ),
      );
  static BoxDecoration get fillTeal => BoxDecoration(
        color: appTheme.teal100,
      );
  static BoxDecoration get gradientTealToTeal => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [appTheme.teal40001, appTheme.teal40001.withOpacity(0)],
        ),
      );

  static BoxDecoration get outlineGray => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.gray70019,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              10,
            ),
          )
        ],
      );
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16.h,
      );
  static BorderRadius get roundedBorder5 => BorderRadius.circular(
        5.h,
      );

  static BorderRadius get roundedBorder40 => BorderRadius.circular(
        40.h,
      );

  static BorderRadius get circleBorder130 => BorderRadius.circular(
        130.h,
      );
  static BorderRadius get circleBorder148 => BorderRadius.circular(
        148.h,
      );
// Rounded borders
  static BorderRadius get roundedBorder20 => BorderRadius.circular(
        20.h,
      );
}
