import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';

ThemeData themeData = ThemeData(
  primarySwatch: primaryColor,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Poppins',
  dividerColor: Colors.black38,
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 28,
      fontFamily: 'Poppins',
      letterSpacing: -1,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontSize: 26,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontSize: 24,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      fontSize: 22,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    headline5: TextStyle(
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
    ),
    headline6: TextStyle(
      fontSize: 18,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    ),
    subtitle1: TextStyle(fontFamily: 'Work Sans', fontWeight: FontWeight.w500),
    subtitle2: TextStyle(fontFamily: 'Work Sans', fontWeight: FontWeight.w500),
    caption: TextStyle(
        fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w600),
  ).apply(
    bodyColor: textColor,
    displayColor: textColor,
  ),
  platform: TargetPlatform.iOS,
);
