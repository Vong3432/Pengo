import 'dart:ui';

import 'package:flutter/material.dart';

Map<int, Color> color = <int, Color>{
  50: const Color.fromRGBO(92, 219, 518, .1),
  100: const Color.fromRGBO(92, 219, 518, .2),
  200: const Color.fromRGBO(92, 219, 518, .3),
  300: const Color.fromRGBO(92, 219, 518, .4),
  400: const Color.fromRGBO(92, 219, 518, .5),
  500: const Color.fromRGBO(92, 219, 518, .6),
  600: const Color.fromRGBO(92, 219, 518, .7),
  700: const Color.fromRGBO(92, 219, 518, .8),
  800: const Color.fromRGBO(92, 219, 518, .9),
  900: const Color.fromRGBO(92, 219, 518, 1),
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

Map<int, Color> danger = <int, Color>{
  50: const Color.fromRGBO(250, 98, 125, .1),
  100: const Color.fromRGBO(250, 98, 125, .2),
  200: const Color.fromRGBO(250, 98, 125, .3),
  300: const Color.fromRGBO(250, 98, 125, .4),
  400: const Color.fromRGBO(250, 98, 125, .5),
  500: const Color.fromRGBO(250, 98, 125, .6),
  600: const Color.fromRGBO(250, 98, 125, .7),
  700: const Color.fromRGBO(250, 98, 125, .8),
  800: const Color.fromRGBO(250, 98, 125, .9),
  900: const Color.fromRGBO(250, 98, 125, 1),
};

Map<int, Color> success = <int, Color>{
  50: const Color.fromRGBO(57, 188, 136, .1),
  100: const Color.fromRGBO(57, 188, 136, .2),
  200: const Color.fromRGBO(57, 188, 136, .3),
  300: const Color.fromRGBO(57, 188, 136, .4),
  400: const Color.fromRGBO(57, 188, 136, .5),
  500: const Color.fromRGBO(57, 188, 136, .6),
  600: const Color.fromRGBO(57, 188, 136, .7),
  700: const Color.fromRGBO(57, 188, 136, .8),
  800: const Color.fromRGBO(57, 188, 136, .9),
  900: const Color.fromRGBO(57, 188, 136, 1),
};

MaterialColor primaryColor = MaterialColor(0xFF5CDB9E, color);
MaterialColor dangerColor = MaterialColor(0xFFFA627D, color);
MaterialColor successColor = MaterialColor(0xFF39BC88, color);
MaterialColor textColor = MaterialColor(0xFF1A212E, text);
