import 'package:ezycourse/app/helpers/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color scaffoldBackgroundColor,
    required Color backgroundColor,
    required Color backgroundColorSecondary,
    required Color primaryTextColor,
    required Color captionTextColor,
    Color? secondaryTextColor,
    required Color accentColor,
    Color? overLineTextColor,
    Color? dividerColor,
    Color? buttonBackgroundColor,
    required Color buttonTextColor,
    Color? cardBackgroundColor,
    Color? disabledColor,
    required Color errorColor,
    required Color unselectedColor,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      fontFamily: 'Figtree',
      useMaterial3: true,
      brightness: brightness,
      dialogBackgroundColor: cardBackgroundColor,
      navigationBarTheme: NavigationBarThemeData(
          backgroundColor: backgroundColor, indicatorColor: accentColor),
      canvasColor: cardBackgroundColor,
      cardColor: cardBackgroundColor,
      dividerColor: dividerColor,
      scaffoldBackgroundColor: backgroundColor,
      dividerTheme: DividerThemeData(
        color: dividerColor,
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardTheme(
        color: cardBackgroundColor,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      primaryColor: accentColor,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: accentColor,
        selectionHandleColor: accentColor,
        cursorColor: accentColor,
      ),
      focusColor: backgroundColorSecondary,
      appBarTheme: AppBarTheme(
        color: cardBackgroundColor,
        iconTheme: IconThemeData(
          color: secondaryTextColor,
        ),
        titleTextStyle: TextStyle(
          color:secondaryTextColor 
        )
      ),
      iconTheme: IconThemeData(
        color: primaryTextColor,
        size: 20.0,
      ),
    
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: accentColor,
          secondary: accentColor,
          surface: scaffoldBackgroundColor,
          error: errorColor,
          onPrimary: buttonTextColor,
          onSecondary: buttonTextColor,
          onSurface: buttonTextColor,
          onError: buttonTextColor,
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      // cupertinoOverrideTheme: CupertinoThemeData(
      //   brightness: brightness,
      //   primaryColor: accentColor,
      // ),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle:
            TextStyle(fontFamily: 'Figtree', color: errorColor),
        labelStyle: TextStyle(
          fontFamily: 'Figtree',
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: primaryTextColor.withOpacity(0.5),
        ),
        hintStyle: TextStyle(
          color: secondaryTextColor,
          fontSize: 13.0,
          fontWeight: FontWeight.w300,
          fontFamily: 'Figtree',
        ),
      ),
      unselectedWidgetColor: unselectedColor,
      textTheme: TextTheme(
        displayLarge: baseTextTheme.displayLarge!.copyWith(
          color: primaryTextColor,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Figtree',
        ),
        displayMedium: baseTextTheme.displayMedium!.copyWith(
          color: primaryTextColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Figtree',
        ),
        displaySmall: baseTextTheme.displaySmall!.copyWith(
          color: primaryTextColor,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          fontFamily: 'Figtree',
        ),
        headlineMedium: baseTextTheme.headlineMedium!.copyWith(
          color: primaryTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Figtree',
        ),
        headlineSmall: baseTextTheme.headlineSmall!.copyWith(
          color: secondaryTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Figtree',
        ),
        titleLarge: baseTextTheme.titleLarge!.copyWith(
          color: primaryTextColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Figtree',
        ),
        bodyLarge: baseTextTheme.bodyLarge!.copyWith(
          color: secondaryTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Figtree',
        ),
        bodyMedium: baseTextTheme.bodyMedium!.copyWith(
          color: captionTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Figtree',
        ),
        labelLarge: baseTextTheme.labelLarge!.copyWith(
          color: primaryTextColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Figtree',
        ),
        bodySmall: baseTextTheme.bodySmall!.copyWith(
          color: captionTextColor,
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'Figtree',
        ),
        labelSmall: baseTextTheme.labelSmall!.copyWith(
            color: overLineTextColor,
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'Figtree',
            letterSpacing: 0),
        titleMedium: baseTextTheme.titleMedium!.copyWith(
          color: primaryTextColor,
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'Figtree',
        ),
        titleSmall: baseTextTheme.titleSmall!.copyWith(
          color: primaryTextColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'Figtree',
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return accentColor;
          }
          return captionTextColor;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return accentColor;
          }
          return captionTextColor;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return accentColor;
          }
          return captionTextColor;
        }),
      ),
      tabBarTheme: TabBarTheme(labelColor: primaryTextColor, unselectedLabelColor: secondaryTextColor),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return accentColor;
          }
          return null;
        }),
      ),
      colorScheme: ColorScheme(
        error: errorColor,
        brightness: brightness,
        onError: errorColor,
        onPrimary: primaryTextColor,
        onSecondary: secondaryTextColor!,
        onSurface: scaffoldBackgroundColor,
        primary: primaryTextColor,
        secondary: secondaryTextColor,
        surface: scaffoldBackgroundColor,
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorConstants.white,
      cardBackgroundColor: ColorConstants.white,
      primaryTextColor: ColorConstants.black,
      unselectedColor: ColorConstants.white,
      secondaryTextColor: ColorConstants.black80,
      overLineTextColor: ColorConstants.black60,
      captionTextColor: ColorConstants.black60,
      accentColor: ColorConstants.deepGreen100,
      dividerColor: ColorConstants.grayLight,
      buttonBackgroundColor: ColorConstants.buttonBgColorPrimary,
      buttonTextColor: ColorConstants.black,
      disabledColor: ColorConstants.blackOverlay,
      errorColor: ColorConstants.redAccent,
      backgroundColor: ColorConstants.lightBgColor,
      backgroundColorSecondary: ColorConstants.white);

  static ThemeData get darkTheme => createTheme(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ColorConstants.black,
        backgroundColor: ColorConstants.darkBgColor,
        backgroundColorSecondary: ColorConstants.black,
        cardBackgroundColor: ColorConstants.black,
        primaryTextColor: ColorConstants.white,
        secondaryTextColor: ColorConstants.white,
        overLineTextColor: ColorConstants.white,
        captionTextColor: ColorConstants.white,
        accentColor: ColorConstants.deepGreen100,
        dividerColor: ColorConstants.black60,
        buttonBackgroundColor: ColorConstants.buttonBgColorSecondary,
        buttonTextColor: ColorConstants.white,
        disabledColor: ColorConstants.blackOverlay,
        errorColor: ColorConstants.redAccent, 
        unselectedColor: ColorConstants.black80,
      );
}
