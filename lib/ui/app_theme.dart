import 'package:fa_dict/ui/color_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const String themeKey = "selectedThemeIndex";
  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      elevation: 1,
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12));
  static final darkTheme = ThemeData(
      primaryColor: ColorPalette.wildWatermelon,
      accentColor: ColorPalette.bilobaFlower,
      scaffoldBackgroundColor: Colors.grey.shade900,
      textTheme: TextTheme(
        headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(fontSize: 17, fontFamily: 'IranSans'),
        bodyText2: TextStyle(fontSize: 17, fontFamily: 'Roboto'),
      ),
      fontFamily: 'IranSans',
      colorScheme: ColorScheme.dark());
  static final lightTheme = ThemeData(
      primaryColor: ColorPalette.wildWatermelon,
      accentColor: ColorPalette.bilobaFlower,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(fontSize: 17, fontFamily: 'IranSans'),
        bodyText2: TextStyle(fontSize: 17, fontFamily: 'Roboto'),
      ),
      fontFamily: 'IranSans',
      colorScheme: ColorScheme.light());
}
