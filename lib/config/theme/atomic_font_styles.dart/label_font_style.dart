import 'package:flutter/material.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/font_style_parameters.dart';
import 'package:tradex_wallet_3/config/theme/custom_colors.dart';

class Label {
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
      fontFamily: 'Archivo',
      fontSize: atMapSize[fontSize],
      height: atMapHeight[fontSize],
      fontWeight: atMapWeight[fontWeight],
      color: atMapColor[fontColor],
    );
  }

  static const Map<AtFontSize, double> atMapSize = {
    AtFontSize.large: 16,
    AtFontSize.medium: 12,
    AtFontSize.small: 10,
  };

  static const Map<AtFontSize, double> atMapHeight = {
    AtFontSize.large: 1.25,
    AtFontSize.medium: 1.33,
    AtFontSize.small: 1,
  };

  static const Map<AtFontWeight, FontWeight> atMapWeight = {
    AtFontWeight.bold: FontWeight.w700,
    AtFontWeight.semibold: FontWeight.w600,
    AtFontWeight.regular: FontWeight.w400,
    AtFontWeight.light: FontWeight.w300,
  };

  static const Map<AtFontColor, Color> atMapColor = {
    AtFontColor.primary: CustomColors.darkSpace,
    AtFontColor.light: CustomColors.white,
  };

  TextStyle largeBold =
      generate(fontSize: AtFontSize.large, fontWeight: AtFontWeight.bold);
  TextStyle largeRegular =
      generate(fontSize: AtFontSize.large, fontWeight: AtFontWeight.regular);
  TextStyle largeSemibold =
      generate(fontSize: AtFontSize.large, fontWeight: AtFontWeight.semibold);

  TextStyle mediumBold =
      generate(fontSize: AtFontSize.medium, fontWeight: AtFontWeight.bold);
  TextStyle mediumLight =
      generate(fontSize: AtFontSize.medium, fontWeight: AtFontWeight.light);
  TextStyle mediumSemibold =
      generate(fontSize: AtFontSize.medium, fontWeight: AtFontWeight.semibold);

  TextStyle smallBold =
      generate(fontSize: AtFontSize.small, fontWeight: AtFontWeight.bold);
  TextStyle smallLight =
      generate(fontSize: AtFontSize.small, fontWeight: AtFontWeight.light);
  TextStyle smallRegular =
      generate(fontSize: AtFontSize.small, fontWeight: AtFontWeight.regular);
}
