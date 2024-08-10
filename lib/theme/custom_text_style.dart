import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get canelaTrial {
    return copyWith(
      fontFamily: 'Canela Trial',
    );
  }

  TextStyle get segoeUI {
    return copyWith(
      fontFamily: 'Segoe UI',
    );
  }

  TextStyle get manrope {
    return copyWith(
      fontFamily: 'Manrope',
    );
  }

  TextStyle get elMessiri {
    return copyWith(
      fontFamily: 'El Messiri',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
// Headline style
  static get headlineLargeManrope => theme.textTheme.headlineLarge!.manrope;
// Title text style
  static get titleMediumSemiBold => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w600,
      );

  static get titleSmallPoppinsWhiteA70001 =>
      theme.textTheme.titleSmall?.canelaTrial.copyWith(
        color: appTheme.whiteA70001,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallPoppinsWhiteA700012 =>
      theme.textTheme.titleSmall?.canelaTrial.copyWith(
        color: appTheme.whiteA70001,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w700,
      );

  static get bodyLargeOnPrimaryContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontSize: 18.fSize,
      );
  static get bodyMediumAmber300 => theme.textTheme.bodyMedium!.copyWith(
      color: appTheme.amber300, fontSize: 16, fontWeight: FontWeight.w600);

  static get bodyMedium13 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 13.fSize,
      );
  static get bodyMediumBluegray70001 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray70001,
      );
  static get bodyMediumBluegray900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray900,
        fontSize: 13.fSize,
      );
  static get bodyMediumGray100 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray100,
        fontSize: 13.fSize,
      );
  static get bodyMediumGray500 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray500,
      );
  static get bodyMediumGray60001 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray60001,
        fontSize: 13.fSize,
      );
  static get bodySmallBluegray30003 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray30003,
      );
  static get bodySmallGray700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray700,
      );
  static get bodySmallGray90001 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray90001,
      );
// Display style
  static get displaySmallCanelaTrial =>
      theme.textTheme.displaySmall!.canelaTrial;

  static get displaySmallCanelaTrial24 =>
      theme.textTheme.headlineSmall!.canelaTrial.copyWith(
          fontSize: 48,
          color: appTheme.blueGray90001,
          fontWeight: FontWeight.w600);

  static get displaySmallCanelaTrial20 =>
      theme.textTheme.headlineSmall!.canelaTrial.copyWith(
          fontSize: 34,
          color: appTheme.blueGray90001,
          fontWeight: FontWeight.w600);

  static get displaySmallCanelaTrial15 =>
      theme.textTheme.headlineSmall!.canelaTrial
          .copyWith(fontSize: 22, color: appTheme.black900);

// Headline text style
  static get headlineSmallCanelaTrialBluegray90001 =>
      theme.textTheme.headlineSmall!.canelaTrial.copyWith(
        color: appTheme.blueGray90001,
        fontWeight: FontWeight.w400,
      );
  static get headlineSmallGray100 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.blueGray90001,
      );
// Label text style
  static get labelLargeManropeBluegray500 =>
      theme.textTheme.labelLarge!.manrope.copyWith(
        color: appTheme.blueGray500,
      );

  static get largeManrope24Bold => theme.textTheme.titleLarge!.manrope.copyWith(
      color: appTheme.black900, fontSize: 24, fontWeight: FontWeight.w800);

  static get labelManropeWhiteSemi20 => theme.textTheme.labelLarge!.manrope
      .copyWith(color: appTheme.whiteA700, fontSize: 20);
  static get labelManropeWhiteSemi18 => theme.textTheme.labelLarge!.manrope
      .copyWith(color: appTheme.whiteA700, fontSize: 18);

  static get labelLargeManropeWhiteTitle =>
      theme.textTheme.labelLarge!.manrope.copyWith(
        color: appTheme.whiteA700,
        fontSize: 32,
        fontWeight: FontWeight.w400,
      );
  static get labelLargeManropeWhiteHeading =>
      theme.textTheme.labelLarge!.manrope.copyWith(
        color: appTheme.whiteA700,
        fontSize: 40,
        fontWeight: FontWeight.w500,
      );
  static get labelLargeManropeWhiteSmall =>
      theme.textTheme.labelLarge!.manrope.copyWith(
        color: appTheme.whiteA700,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      );

  static get labelLargeManropeWhiteSmall14 =>
      theme.textTheme.labelLarge!.manrope.copyWith(
        color: appTheme.whiteA700,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );
  static get labelLargeManropeBluegray90002 =>
      theme.textTheme.labelLarge!.manrope.copyWith(
        color: appTheme.blueGray90002.withOpacity(0.77),
        fontWeight: FontWeight.w500,
      );
  static get labelLargeManropeBluegray90003 =>
      theme.textTheme.labelLarge!.manrope.copyWith(
        color: appTheme.blueGray90003.withOpacity(0.76),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w500,
      );
  static get labelLargeManropeBluegray9000313 =>
      theme.textTheme.labelLarge!.manrope.copyWith(
        color: appTheme.blueGray90003,
        fontSize: 13.fSize,
      );
  static get labelLargeManropeTeal800 =>
      theme.textTheme.labelLarge!.manrope.copyWith(
        color: appTheme.teal40001,
      );

  static get buttonText => theme.textTheme.labelLarge!.manrope.copyWith(
      color: appTheme.amber600, fontWeight: FontWeight.w900, fontSize: 16);
  static get labelLargeManropeWhiteA700 =>
      theme.textTheme.labelLarge!.manrope.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w700,
      );
  static get labelLargeManropeWhiteA700_1 =>
      theme.textTheme.labelLarge!.manrope.copyWith(
        color: appTheme.whiteA700.withOpacity(0.66),
      );
  static get labelMediumBlue800 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.blue800,
      );
  static get labelMediumTeal800 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.teal800,
      );
// Title text style
  static get titleLargeManrope => theme.textTheme.titleLarge!.manrope.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 18.fSize,
      );
  static get titleMediumBluegray500 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray500,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumBold => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get titleMediumGray70002 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray70002,
      );

  static get titleMediumGray900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray900,
      );
  static get titleMediumGray90001 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray90001,
      );
  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleSmallBluegray400 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray400,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallBluegray500 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray500,
        fontSize: 14.fSize,
      );
  static get titleSmallBluegray600 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray600,
        fontSize: 14.fSize,
      );
  static get titleSmallBluegray900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray900,
        fontSize: 14.fSize,
      );
  static get titleSmallBluegray90002 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray90002,
        fontSize: 14.fSize,
      );
  static get titleSmallBluegray90003 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray90003,
        fontSize: 14.fSize,
      );
  static get titleSmallWhiteA700 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleSmallWhiteA700Medium => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallYellow200a9 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.yellow200A9,
        fontSize: 14.fSize,
      );
}
