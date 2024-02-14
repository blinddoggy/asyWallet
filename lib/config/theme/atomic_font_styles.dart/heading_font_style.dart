import 'package:flutter/material.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/font_style_parameters.dart';
import 'package:tradex_wallet_3/config/theme/custom_colors.dart';

class Heading {
  static TextStyle generate({
    AtFontColor fontColor = AtFontColor.primary,
    AtFontWeight fontWeight = AtFontWeight.bold,
    AtFontSize fontSize = AtFontSize.large,
  }) {
    assert(
      (atMapSize.keys.contains(fontSize) ||
          atMapWeight.keys.contains(fontWeight) ||
          atMapColor.keys.contains(fontColor)),
      'Este estilo no está permitido según el sistema de diseño',
    );
    return TextStyle(
      fontFamily: 'TitilliumWeb',
      fontSize: atMapSize[fontSize],
      height: atMapHeight[fontSize],
      color: atMapColor[fontColor],
      fontWeight: atMapWeight[fontWeight],
    );
  }

  static const Map<AtFontSize, double> atMapSize = {
    AtFontSize.large: 32,
    AtFontSize.medium: 20,
    AtFontSize.small: 16,
  };

  static const Map<AtFontSize, double> atMapHeight = {
    AtFontSize.large: 1.25,
    AtFontSize.medium: 1.2,
    AtFontSize.small: 1.25,
  };

  static const Map<AtFontWeight, FontWeight> atMapWeight = {
    AtFontWeight.bold: FontWeight.w700,
  };

  static const Map<AtFontColor, Color> atMapColor = {
    AtFontColor.primary: CustomColors.primary,
    AtFontColor.secondary: CustomColors.graySpace,
    AtFontColor.light: CustomColors.white,
  };

  TextStyle largePrimary = generate(
    fontSize: AtFontSize.large,
    fontColor: AtFontColor.primary,
  );
  TextStyle mediumPrimary = generate(
    fontSize: AtFontSize.medium,
    fontColor: AtFontColor.primary,
  );
  TextStyle smallPrimary = generate(
    fontSize: AtFontSize.small,
    fontColor: AtFontColor.primary,
  );

  TextStyle largeSecondary = generate(
    fontSize: AtFontSize.large,
    fontColor: AtFontColor.secondary,
  );
  TextStyle mediumSecondary = generate(
    fontSize: AtFontSize.medium,
    fontColor: AtFontColor.secondary,
  );
  TextStyle smallSecondary = generate(
    fontSize: AtFontSize.small,
    fontColor: AtFontColor.secondary,
  );
}
