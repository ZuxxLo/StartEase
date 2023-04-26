import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startease/main.dart';
import 'colors.dart';

class Themes extends GetxController {
  static TextButtonThemeData textButtonThemeData = TextButtonThemeData(
      style: ButtonStyle(
    fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, 50)),
    textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
    alignment: Alignment.center,
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    foregroundColor: MaterialStateProperty.all<Color>(whiteColor),
    backgroundColor: MaterialStateProperty.all<Color>(bluePurpleColor),
    overlayColor: MaterialStateColor.resolveWith(
        (states) => transparentColor.withOpacity(0.2)),
  ));

  static ThemeData customLightTheme = ThemeData.light().copyWith(
      primaryColorDark: whiteColor,
      primaryColorLight: darkBlueColor,
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: blackColor, fontSize: 16),
        bodyLarge: TextStyle(color: blackColor),
        bodyMedium: TextStyle(color: blackColor, fontSize: 22),
        titleSmall: TextStyle(color: blackColor, fontSize: 20),
        titleLarge: TextStyle(color: blackColor, fontSize: 25),
        titleMedium: TextStyle(color: blackColor, fontSize: 19),
      ).apply(
        fontFamily: 'Raleway',
      ),
      scaffoldBackgroundColor: whiteColor,
      colorScheme: const ColorScheme.light()
          .copyWith(primary: bluePurpleColor, secondary: bluePurpleColor),
      appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: transparentColor,
          centerTitle: true,
          surfaceTintColor: darkBlueColor,
          foregroundColor: darkBlueColor),
      primaryColor: bluePurpleColor,
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: bluePurpleColor),
      inputDecorationTheme: const InputDecorationTheme(
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: transparentColor)),
        fillColor: lightBlueColor,
        filled: true,
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
            borderSide: BorderSide(color: transparentColor, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: bluePurpleColor, width: 2)),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        hintStyle: TextStyle(fontSize: 19),
      ),
      textButtonTheme: textButtonThemeData,
      cardTheme: CardTheme(
          elevation: 5,
          color: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      listTileTheme: ListTileThemeData(
        visualDensity: const VisualDensity(vertical: -4),
        textColor: greyColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
        tileColor: lightBlueColor,
      ));

  static ThemeData customDarkTheme = ThemeData.dark().copyWith(
      primaryColorDark: darkBlueColor,
      primaryColorLight: whiteColor,
      colorScheme: const ColorScheme.dark()
          .copyWith(primary: bluePurpleColor, secondary: bluePurpleColor),
      appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: transparentColor,
          centerTitle: true,
          foregroundColor: whiteColor),
      primaryColor: bluePurpleColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: bluePurpleColor,
      ),
      listTileTheme: ListTileThemeData(
        visualDensity: const VisualDensity(vertical: -4),
        textColor: whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
        tileColor: lightBlueColor.withAlpha(50),
      ),
      inputDecorationTheme: InputDecorationTheme(
        disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: transparentColor)),
        fillColor: lightBlueColor.withAlpha(50),
        filled: true,
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: redColor)),
        errorStyle: const TextStyle(color: redColor),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: redColor)),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: transparentColor, width: 2)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: bluePurpleColor, width: 2)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        hintStyle: const TextStyle(fontSize: 19),
      ),
      textButtonTheme: textButtonThemeData,
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: whiteColor, fontSize: 16),
        bodyLarge: TextStyle(color: whiteColor),
        bodyMedium: TextStyle(color: whiteColor, fontSize: 22),
        titleSmall: TextStyle(color: whiteColor, fontSize: 20),
        titleLarge: TextStyle(color: whiteColor, fontSize: 25),
        titleMedium: TextStyle(color: whiteColor, fontSize: 19),
      ).apply(
        fontFamily: 'Raleway',
      ),
      cardTheme: CardTheme(
          elevation: 5,
          color: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));

  static ThemeData getThemeMode() {
    return MainFunctions.sharredPrefs!.getBool("isDarkTheme") ?? false
        ? Themes.customDarkTheme
        : Themes.customLightTheme;
  }
}
