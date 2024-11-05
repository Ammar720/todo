import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF5D9CEC);
  static const Color backgroundLight = Color(0xFFDFECDB);
  static const Color backgroundDark = Color(0xFF060E1E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF363636);
  static const Color green = Color(0xFF61E757);
  static const Color grey = Color(0xFFC8C9CB);
  static const Color red = Color(0xFFEC4B4B);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    appBarTheme:
        AppBarTheme(centerTitle: true, backgroundColor: Colors.transparent),
    scaffoldBackgroundColor: backgroundLight,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      selectedItemColor: primary,
      unselectedItemColor: grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(size: 35),
      unselectedIconTheme: IconThemeData(size: 35),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: white,
      backgroundColor: primary,
      shape: CircleBorder(
        side: BorderSide(
          color: white,
          width: 4,
        ),
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      titleSmall: TextStyle(
        color: black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primary),
        foregroundColor: WidgetStatePropertyAll(white),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      foregroundColor: primary,
    )),
  );
  static ThemeData darkTheme = ThemeData();
}
