import 'package:flutter/material.dart';
import 'package:qent/core/resources/color_manager.dart';

class AppTheme {
  static const String _fontFamily = 'Roboto';
  static ThemeData mainTheme = ThemeData(
    fontFamily: _fontFamily,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: ColorManager.black),
      backgroundColor: ColorManager.veryLightGrey,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: ColorManager.veryLightGrey,

    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.w600,
        color: ColorManager.white,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        color: ColorManager.black,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: ColorManager.semiGrey,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: ColorManager.primary,
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w400,
        color: ColorManager.error,
      ),
      // bodyMedium: TextStyle(
      //   fontWeight: FontWeight.w400,
      //   color: ColorManager.black,
      // ),
      // bodySmall: TextStyle(
      //   fontWeight: FontWeight.w400,
      //   color: ColorManager.semiGrey,
      // ),
    ),
  );
}
