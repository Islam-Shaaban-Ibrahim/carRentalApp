import 'package:flutter/material.dart';
import 'package:qent/core/theme/color_manager.dart';

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
      // titleMedium: TextStyle(
      //   fontWeight: FontWeight.w700,
      //   color: ColorsManager.blackColor,
      // ),
      // titleSmall: TextStyle(
      //   fontWeight: FontWeight.w700,

      //   color: ColorsManager.whiteColor,
      // ),
    ),
  );
}
