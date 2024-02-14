import 'package:flutter/material.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/font_style_parameters.dart';
import 'package:tradex_wallet_3/config/theme/custom_colors.dart';

class Button {
  static TextStyle generate({
    AtFontSize fontSize = AtFontSize.large,
    AtFontWeight fontWeight = AtFontWeight.bold,
    AtFontColor fontColor = AtFontColor.primary,
  }) {
    assert(
      (atMapSize.keys.contains(fontSize) ||
          atMapWeight.keys.contains(fontWeight) ||
          atMapColor.keys.contains(fontColor)),
      'Este estilo no está permitido según el sistema de diseño',
    );

    return TextStyle(
      color: atMapColor[fontColor],
      fontFamily: 'TitilliumWeb',
      fontSize: atMapSize[fontSize],
      fontWeight: atMapWeight[fontWeight],
      height: atMapHeight[fontSize],
    );
  }

  static const Map<AtFontSize, double> atMapSize = {
    AtFontSize.large: 14,
    AtFontSize.medium: 12,
  };

  static const Map<AtFontSize, double> atMapHeight = {
    AtFontSize.large: 1.4,
    AtFontSize.medium: 1.66,
  };

  static const Map<AtFontWeight, FontWeight> atMapWeight = {
    AtFontWeight.bold: FontWeight.w700,
    AtFontWeight.semibold: FontWeight.w600,
    AtFontWeight.regular: FontWeight.w400,
  };

  static const Map<AtFontColor, Color> atMapColor = {
    AtFontColor.primary: CustomColors.white,
    AtFontColor.secondary: CustomColors.primary,
    AtFontColor.accent: CustomColors.accent,
    AtFontColor.dark: CustomColors.darkSpace,
    AtFontColor.mid: CustomColors.graySpace,
    AtFontColor.light: CustomColors.white,
  };

  TextStyle largePrimaryBold =
      generate(fontSize: AtFontSize.large, fontWeight: AtFontWeight.bold);
  // TextStyle largePrimarySemibold =
  //     generate(fontSize: AtFontSize.large, fontWeight: AtFontWeight.semibold);
  // TextStyle largePrimaryRegular =
  //     generate(fontSize: AtFontSize.large, fontWeight: AtFontWeight.regular);
  // TextStyle largeSecondaryBold = generate(
  //   fontSize: AtFontSize.large,
  //   fontWeight: AtFontWeight.bold,
  //   fontColor: AtFontColor.secondary,
  // );
  // TextStyle largeSecondarySemibold = generate(
  //   fontSize: AtFontSize.large,
  //   fontWeight: AtFontWeight.semibold,
  //   fontColor: AtFontColor.secondary,
  // );
  // TextStyle largeSecondaryRegular = generate(
  //   fontSize: AtFontSize.large,
  //   fontWeight: AtFontWeight.regular,
  //   fontColor: AtFontColor.secondary,
  // );

  // TextStyle mediumPrimaryBold =
  //     generate(fontSize: AtFontSize.medium, fontWeight: AtFontWeight.bold);
  // TextStyle mediumPrimarySemibold =
  //     generate(fontSize: AtFontSize.medium, fontWeight: AtFontWeight.semibold);
  // TextStyle mediumPrimaryRegular =
  //     generate(fontSize: AtFontSize.medium, fontWeight: AtFontWeight.regular);
  // TextStyle mediumSecondaryBold = generate(
  //     fontSize: AtFontSize.medium,
  //     fontWeight: AtFontWeight.bold,
  //     fontColor: AtFontColor.secondary);
  TextStyle mediumSecondarySemibold = generate(
      fontSize: AtFontSize.medium,
      fontWeight: AtFontWeight.semibold,
      fontColor: AtFontColor.secondary);
  // TextStyle mediumSecondaryRegular = generate(
  //     fontSize: AtFontSize.medium,
  //     fontWeight: AtFontWeight.regular,
  //     fontColor: AtFontColor.secondary);

  TextStyle navbar = generate(
    fontSize: AtFontSize.medium,
    fontWeight: AtFontWeight.bold,
    fontColor: AtFontColor.dark,
  );
  TextStyle navbarAccent = generate(
    fontSize: AtFontSize.medium,
    fontWeight: AtFontWeight.bold,
    fontColor: AtFontColor.accent,
  );
}
