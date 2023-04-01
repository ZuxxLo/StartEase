import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'colors.dart';

class Themes extends GetxController {
  static InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: redColor)),
      errorStyle: TextStyle(color: redColor),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: redColor)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: greyColor, width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: purpleColor, width: 2)),
      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20));
  static TextButtonThemeData textButtonThemeData = TextButtonThemeData(
      style: ButtonStyle(
    fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, 50)),
    textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
    alignment: Alignment.center,
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    foregroundColor: MaterialStateProperty.all<Color>(whiteColor),
    backgroundColor: MaterialStateProperty.all<Color>(purpleColor),
    overlayColor: MaterialStateColor.resolveWith(
        (states) => transparentColor.withOpacity(0.2)),
  ));
  static ThemeData customLightTheme = ThemeData.light().copyWith(
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: blackColor, fontSize: 16),
        bodyLarge: TextStyle(color: blackColor),
        bodyMedium: TextStyle(color: blackColor),
        titleSmall: TextStyle(color: blackColor , fontSize: 20),
        titleLarge: TextStyle(color: blackColor, fontSize: 30),
        titleMedium: TextStyle(color: blackColor, fontSize: 22),
      ).apply(
        fontFamily: 'Raleway',
      ),
      scaffoldBackgroundColor: whiteColor,
      colorScheme: const ColorScheme.light()
          .copyWith(primary: purpleColor, secondary: bluePurpleColor),
      appBarTheme: const AppBarTheme(backgroundColor: purpleColor),
      primaryColor: purpleColor,
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: purpleColor),
      inputDecorationTheme: inputDecorationTheme,
      textButtonTheme: textButtonThemeData,
      cardTheme: CardTheme(
          elevation: 5,
          color: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      listTileTheme: ListTileThemeData(  
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
      ));

  static ThemeData customDarkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,
    colorScheme: const ColorScheme.dark()
        .copyWith(primary: purpleColor, secondary: bluePurpleColor),
    appBarTheme: const AppBarTheme(backgroundColor: purpleColor),
    primaryColor: purpleColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: purpleColor,
    ),
    inputDecorationTheme: inputDecorationTheme,
    textButtonTheme: textButtonThemeData,
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: whiteColor, fontSize: 16),
      bodyLarge: TextStyle(color: whiteColor),
      bodyMedium: TextStyle(color: whiteColor),
      titleSmall: TextStyle(color: whiteColor),
      titleLarge: TextStyle(color: whiteColor, fontSize: 30),
      titleMedium: TextStyle(color: whiteColor, fontSize: 25),
    ).apply(
      fontFamily: 'Raleway',
    ),
  );

  static ThemeData getThemeMode() {
    return Themes.customLightTheme;

    // sharredPrefs!.getBool("isDarkTheme") ?? false
    //     ? Themes.customDarkTheme
    //     : Themes.customLightTheme;
  }
}
