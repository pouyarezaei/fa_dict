import 'package:flutter/material.dart';


class AppTheme {
  static const String themeKey = "selectedThemeIndex";

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      fontFamily: 'IranSans',
      colorScheme: ColorScheme.dark());
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'IranSans',
      colorScheme: ColorScheme.light());
}
