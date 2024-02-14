import 'package:flutter/material.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/_atomic_font_styles.dart'
    as atomic;

import 'atomic_font_styles.dart/font_style_parameters.dart';

class AtomicTextStyle {
  static atomic.Display display = atomic.Display();
  static atomic.Heading heading = atomic.Heading();
  static atomic.Body body = atomic.Body();
  static atomic.Label label = atomic.Label();
  static atomic.Button button = atomic.Button();

  static TextTheme tradexTextTheme() {
    final TextTheme myTextTheme = TextTheme(
      displayLarge: atomic.Display.generate(
        fontSize: AtFontSize.large,
        fontColor: AtFontColor.primary,
        fontWeight: AtFontWeight.bold,
      ),
      displayMedium: atomic.Display.generate(
        fontSize: AtFontSize.medium,
        fontColor: AtFontColor.primary,
        fontWeight: AtFontWeight.regular,
      ),
      displaySmall: atomic.Display.generate(
        fontSize: AtFontSize.small,
        fontColor: AtFontColor.primary,
        fontWeight: AtFontWeight.regular,
      ),

      headlineLarge: atomic.Heading.generate(
        fontSize: AtFontSize.large,
        fontColor: AtFontColor.primary,
      ),
      headlineMedium: atomic.Heading.generate(
        fontSize: AtFontSize.medium,
        fontColor: AtFontColor.primary,
      ),
      headlineSmall: atomic.Heading.generate(
        fontSize: AtFontSize.small,
        fontColor: AtFontColor.primary,
      ),
      // titleLarge: const TextStyle(
      //   fontFamily: 'TitilliumWeb',
      //   fontSize: 24,
      //   fontWeight: FontWeight.w600,
      //   color: textColor,
      // ),
      // titleMedium: const TextStyle(
      //   fontFamily: 'TitilliumWeb',
      //   fontSize: 20,
      //   fontWeight: FontWeight.w600,
      //   color: textColor,
      // ),
      // titleSmall: const TextStyle(
      //   fontFamily: 'TitilliumWeb',
      //   fontSize: 16,
      //   fontWeight: FontWeight.w600,
      //   color: textColor,
      // ),
      bodyLarge: atomic.Body.generate(fontSize: AtFontSize.large),
      bodyMedium: atomic.Body.generate(fontSize: AtFontSize.medium),
      bodySmall: atomic.Body.generate(fontSize: AtFontSize.small),

      labelLarge: atomic.Label.generate(
        fontSize: AtFontSize.large,
        fontWeight: AtFontWeight.regular,
      ),
      labelMedium: atomic.Label.generate(
        fontSize: AtFontSize.medium,
        fontWeight: AtFontWeight.semibold,
      ),
      labelSmall: atomic.Label.generate(
        fontSize: AtFontSize.small,
        fontWeight: AtFontWeight.light,
      ),
    );

    return myTextTheme;
  }
}
