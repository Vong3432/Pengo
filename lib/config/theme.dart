import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/helpers/theme/custom_font.dart';

ThemeData themeData = ThemeData(
  primarySwatch: primaryColor,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: whiteColor,
  // fontFamily: 'Poppins',
  appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: textColor)),
  dividerTheme: DividerThemeData(color: greyBgColor, thickness: 2.5),
  dividerColor: greyBgColor,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
    // fillColor: greyBgColor,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 28,
      // fontFamily: 'Poppins',
      letterSpacing: -1,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontSize: 26,
      // fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontSize: 24,
      // fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      fontSize: 22,
      // fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    headline5: TextStyle(
      fontSize: 20,
      // fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
    ),
    headline6: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyText1: TextStyle(height: 1.6),
    bodyText2: TextStyle(height: 1.6, fontSize: 16),
    subtitle1: TextStyle(fontWeight: FontWeight.w500),
    subtitle2: TextStyle(fontWeight: FontWeight.w500),
    caption: TextStyle(
        // fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w600),
  ).apply(
    bodyColor: textColor,
    displayColor: textColor,
  ),
  platform: TargetPlatform.iOS,
);
