import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/resources/color_manager.dart';

const String _fontFamily = 'Roboto';
final _radius = BorderRadius.circular(10.r);

class AppTheme {
  static ThemeData mainTheme = ThemeData(
    iconTheme: const IconThemeData(color: ColorManager.primary),

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

    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorManager.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorManager.lightGrey),
        borderRadius: _radius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorManager.primary),
        borderRadius: _radius,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorManager.error),
        borderRadius: _radius,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorManager.error),
        borderRadius: _radius,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorManager.lightGrey),
        borderRadius: _radius,
      ),
    ),
  );
}
