import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../utils/pref_utils.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // The current app theme
  var _appTheme = PrefUtils().getThemeData();

// A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.whiteA700,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.whiteA700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.black900.withOpacity(0.18),
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyMedium: TextStyle(
          color: appTheme.gray70001,
          fontSize: 14.fSize,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.gray80090,
          fontSize: 12.fSize,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          color: appTheme.blueGray90001,
          fontSize: 36.fSize,
          fontFamily: 'El Messiri',
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          color: appTheme.blueGray500,
          fontSize: 24.fSize,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: appTheme.black900,
          fontSize: 12.fSize,
          fontFamily: 'Segoe UI',
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: appTheme.gray600,
          fontSize: 11.fSize,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: appTheme.blueGray90002,
          fontSize: 20.fSize,
          fontFamily: 'Canela Trial',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: appTheme.blueGray90002,
          fontSize: 16.fSize,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: appTheme.blueGray700,
          fontSize: 15.fSize,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Amber
  Color get amber300 => Color(0XFFFFD866);
  Color get amber600 => Color(0XFFEEBB01);
  Color get amber700 => Color(0XFFFA9D08);
// Black
  Color get black900 => Color(0XFF000000);
// Blue
  Color get blue400 => Color(0XFF3C95E5);
  Color get blue800 => Color(0XFF22649F);
// BlueGray
  Color get blueGray300 => Color(0XFF83A7A0);
  Color get blueGray30001 => Color(0XFFA1ACB5);
  Color get blueGray30002 => Color(0XFFA1B5AE);
  Color get blueGray30003 => Color(0XFF9CA8BA);
  Color get blueGray400 => Color(0XFF898995);
  Color get blueGray40001 => Color(0XFF888888);
  Color get blueGray500 => Color(0XFF4F9E81);
  Color get blueGray600 => Color(0XFF3E8E71);
  Color get blueGray700 => Color(0XFF515151);
  Color get blueGray70001 => Color(0XFF50525A);
  Color get blueGray900 => Color(0XFF2E2E2E);
  Color get blueGray90001 => Color(0XFF27364E);
  Color get blueGray90002 => Color(0XFF323232);
  Color get blueGray90003 => Color(0XFF383333);
// Gray
  Color get gray100 => Color(0XFFF4F4F4);
  Color get gray10001 => Color(0XFFF0FCF8);
  Color get gray300 => Color(0XFFE6E6E6);
  Color get gray30001 => Color(0XFFDBEAE5);
  Color get gray30002 => Color(0XFFCFEEE3);
  Color get gray50 => Color(0XFFFAFAFA);
  Color get gray500 => Color(0XFF969696);
  Color get gray50001 => Color(0XFF929292);
  Color get gray5001 => Color(0XFFF5F6FC);
  Color get gray600 => Color(0XFF838383);
  Color get gray60001 => Color(0XFF767676);
  Color get gray700 => Color(0XFF6B6969);
  Color get gray70001 => Color(0XFF606060);
  Color get gray70002 => Color(0XFF616161);
  Color get gray800 => Color(0XFF373742);
  Color get gray80001 => Color(0XFF4C4C4C);
  Color get gray80090 => Color(0X904F4F4F);
  Color get gray900 => Color(0XFF1C1B1D);
  Color get gray90001 => Color(0XFF1C1C1C);
// Green
  Color get green200 => Color(0XFF9BC3B5);
  Color get green400 => Color(0XFF67C15E);
  Color get green600 => Color(0XFF378E6E);
  Color get greenA100 => Color(0XFFB2F3DB);
  Color get greenA700 => Color(0XFF1ED760);
// Teal
  Color get teal50 => Color(0XFFDFF5F1);
  Color get teal800 => Color(0XFF227758);
  Color get teal80001 => Color(0XFF237657);
  Color get teal900 => Color(0XFF00603D);
// White
  Color get whiteA700 => Color(0XFFFFFFFF);
// Yellow
  Color get yellow200A9 => Color(0XA9FFEE99);

  Color get teal100 => Color(0XFFADF0D8);

  Color get teal300 => Color(0XFF57C19A);
  Color get teal400 => Color(0XFF39B588);

  Color get gray10002 => Color(0XFFF7F5EF);

  Color get teal40001 => Color(0XFF3DBA8C);

  Color get gray70019 => Color(0X19555E68);
  Color get blueGray3000c => Color(0X0C8D9BAA);
   Color get amber400 => Color(0XFFFFCD19);
}
