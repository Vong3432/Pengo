import 'dart:ui';

import 'package:flutter/material.dart';

Map<int, Color> color = <int, Color>{
  50: const Color.fromRGBO(23, 185, 88, .1),
  100: const Color.fromRGBO(23, 185, 88, .2),
  200: const Color.fromRGBO(23, 185, 88, .3),
  300: const Color.fromRGBO(23, 185, 88, .4),
  400: const Color.fromRGBO(23, 185, 88, .5),
  500: const Color.fromRGBO(23, 185, 88, .6),
  600: const Color.fromRGBO(23, 185, 88, .7),
  700: const Color.fromRGBO(23, 185, 88, .8),
  800: const Color.fromRGBO(23, 185, 88, .9),
  900: const Color.fromRGBO(23, 185, 88, 1),
};

Map<int, Color> text = <int, Color>{
  50: const Color.fromRGBO(26, 33, 46, .1),
  100: const Color.fromRGBO(26, 33, 46, .2),
  200: const Color.fromRGBO(26, 33, 46, .3),
  300: const Color.fromRGBO(26, 33, 46, .4),
  400: const Color.fromRGBO(26, 33, 46, .5),
  500: const Color.fromRGBO(26, 33, 46, .6),
  600: const Color.fromRGBO(26, 33, 46, .7),
  700: const Color.fromRGBO(26, 33, 46, .8),
  800: const Color.fromRGBO(26, 33, 46, .9),
  900: const Color.fromRGBO(26, 33, 46, 1),
};

MaterialColor primaryColor = MaterialColor(0xFF17B958, color);
MaterialColor textColor = MaterialColor(0xFF1A212E, text);
