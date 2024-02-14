import 'package:flutter/material.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/font_style_parameters.dart';
import 'package:tradex_wallet_3/config/theme/custom_colors.dart';

class Display {
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
      fontWeight: atMapWeight[fontWeight],
      color: atMapColor[fontColor],
    );
  }

  static const Map<AtFontSize, double> atMapSize = {
    AtFontSize.large: 48,
    AtFontSize.medium: 40,
    AtFontSize.small: 32,
  };

  static const Map<AtFontSize, double> atMapHeight = {
    AtFontSize.large: 1,
    AtFontSize.medium: 1.2,
    AtFontSize.small: 1.2,
  };

  static const Map<AtFontWeight, FontWeight> atMapWeight = {
    AtFontWeight.bold: FontWeight.w700,
    AtFontWeight.semibold: FontWeight.w600,
    AtFontWeight.regular: FontWeight.w400,
    AtFontWeight.light: FontWeight.w300,
  };

  static const Map<AtFontColor, Color> atMapColor = {
    AtFontColor.primary: CustomColors.primary,
  };

  TextStyle largePrimaryBold = generate(
      fontSize: AtFontSize.large,
      fontColor: AtFontColor.primary,
      fontWeight: AtFontWeight.bold);
  TextStyle largePrimaryLigth = generate(
      fontSize: AtFontSize.large,
      fontColor: AtFontColor.primary,
      fontWeight: AtFontWeight.light);
  TextStyle mediumPrimarySemibold = generate(
      fontSize: AtFontSize.medium,
      fontColor: AtFontColor.primary,
      fontWeight: AtFontWeight.semibold);
  TextStyle mediumPrimaryRegular = generate(
      fontSize: AtFontSize.medium,
      fontColor: AtFontColor.primary,
      fontWeight: AtFontWeight.regular);
  TextStyle smallPrimarySemibold = generate(
      fontSize: AtFontSize.small,
      fontColor: AtFontColor.primary,
      fontWeight: AtFontWeight.semibold);
  TextStyle smallPrimaryRegular = generate(
      fontSize: AtFontSize.small,
      fontColor: AtFontColor.primary,
      fontWeight: AtFontWeight.regular);
  TextStyle smallPrimaryLight = generate(
      fontSize: AtFontSize.small,
      fontColor: AtFontColor.primary,
      fontWeight: AtFontWeight.light);
}
