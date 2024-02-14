import 'package:flutter/material.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/font_style_parameters.dart';
import 'package:tradex_wallet_3/config/theme/custom_colors.dart';

class Body {
  static TextStyle generate({
    AtFontColor fontColor = AtFontColor.dark,
    AtFontWeight fontWeight = AtFontWeight.regular,
    AtFontSize fontSize = AtFontSize.large,
  }) {
    assert(
      (atMapSize.keys.contains(fontSize) ||
          atMapWeight.keys.contains(fontWeight) ||
          atMapColor.keys.contains(fontColor)),
      'Este estilo no está permitido según el sistema de diseño',
    );
    return TextStyle(
      color: atMapColor[fontColor],
      fontFamily: 'Archivo',
      fontSize: atMapSize[fontSize],
      fontWeight: atMapWeight[fontWeight],
    );
  }

  static const Map<AtFontSize, double> atMapSize = {
    AtFontSize.lead: 20,
    AtFontSize.large: 16,
    AtFontSize.medium: 12,
    AtFontSize.small: 10,
  };

  static const Map<AtFontSize, double> atMapHeight = {
    AtFontSize.lead: 1.6,
    AtFontSize.large: 1.5,
    AtFontSize.medium: 1.33,
    AtFontSize.small: 1.6,
  };

  static const Map<AtFontWeight, FontWeight> atMapWeight = {
    AtFontWeight.bold: FontWeight.w700,
  };

  static const Map<AtFontColor, Color> atMapColor = {
    AtFontColor.dark: CustomColors.graySpace,
    AtFontColor.primary: CustomColors.primary,
    AtFontColor.light: CustomColors.white,
  };

  // TextStyle lead = generate(fontSize: 20, h: 1.6, fontWeight: AtFontWeight.light);
  TextStyle lead = generate(
    fontSize: AtFontSize.lead,
    fontWeight: AtFontWeight.light,
  );

  TextStyle large = generate(fontSize: AtFontSize.large);
  TextStyle medium = generate(fontSize: AtFontSize.medium);
  TextStyle small = generate(fontSize: AtFontSize.small);
}
