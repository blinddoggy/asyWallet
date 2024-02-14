import 'package:flutter/material.dart';
import 'package:tradex_wallet_3/config/theme/custom_colors.dart';
import 'package:tradex_wallet_3/config/theme/atomic_text_theme.dart';

class AppTheme {
  final bool isDarkmode;
  final int selectedColor;

  AppTheme({
    this.selectedColor = 1,
    this.isDarkmode = false,
  })  : assert(selectedColor >= 0, 'Selected color must be greater then 0'),
        assert(selectedColor < CustomColors.colorList.length,
            'Selected color must be less or equal than ${CustomColors.colorList.length - 1}');

  static ButtonStyle buttonStyleIconSmall = ButtonStyle(
    iconColor: const MaterialStatePropertyAll(CustomColors.white),
    padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16, vertical: 4)),
    iconSize: const MaterialStatePropertyAll(16),
    textStyle:
        MaterialStatePropertyAll(AtomicTextStyle.button.largePrimaryBold),
  );

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        fontFamily: 'TitilliumWeb',
        // brightness: isDarkmode ? Brightness.dark : Brightness.light,
        // colorSchemeSeed: CustomColors.colorList[selectedColor],
        colorScheme: ColorScheme(
          background: CustomColors.lightSpace,
          brightness: isDarkmode ? Brightness.dark : Brightness.light,
          error: CustomColors.accent,
          onBackground:
              isDarkmode ? CustomColors.lightSpace : CustomColors.lightSpace,
          onError: CustomColors.white,
          onPrimary: CustomColors.white,
          onSecondary: CustomColors.white,
          onSurface: CustomColors.darkSpace,
          primary: CustomColors.primary,
          secondary: CustomColors.accent,
          surface: CustomColors.lightSilver,
        ),
        splashColor: CustomColors.primary.withOpacity(0.2),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: CustomColors.accent,
          unselectedIconTheme:
              const IconThemeData(color: CustomColors.darkSpace),
          unselectedItemColor: CustomColors.darkSpace,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedLabelStyle: AtomicTextStyle.button.navbarAccent,
          unselectedLabelStyle: AtomicTextStyle.button.navbar,
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: AtomicTextStyle.tradexTextTheme(),

        // buttons
        filledButtonTheme: FilledButtonThemeData(
          style: AppTheme.buttonStyleIconSmall,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.primary,
            foregroundColor: CustomColors.white,
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            fixedSize: const Size(40, 40),
            iconSize: 10,
            foregroundColor: CustomColors.primary,
            backgroundColor: Colors.transparent,
            elevation: 2,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: CustomColors.darkSilver,
            ),
          ),
          floatingLabelStyle: AtomicTextStyle.label.largeSemibold,
          // color
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.primary),
          ),

          helperStyle: AtomicTextStyle.label.smallLight,
        ),
        appBarTheme: AppBarTheme(
          surfaceTintColor: CustomColors.accent,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: AtomicTextStyle.heading.smallPrimary,
          iconTheme: const IconThemeData(
            color: CustomColors.primary,
            size: 24,
          ),
        ),
      );

  AppTheme copyWith({bool? isDarkmode, int? selectedColor}) => AppTheme(
      isDarkmode: isDarkmode ?? this.isDarkmode,
      selectedColor: selectedColor ?? this.selectedColor);
}
