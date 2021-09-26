import 'package:flutter/material.dart';
import 'color.dart';

List<BoxShadow> normalShadow(ThemeData theme) {
  return <BoxShadow>[
    BoxShadow(
        color: theme.primaryColor.withOpacity(0.05),
        offset: const Offset(0, 4),
        blurRadius: 15),
    BoxShadow(
      color: textColor.withOpacity(0.07),
      blurRadius: 30,
      spreadRadius: 5,
      offset: const Offset(2, 4),
    ),
  ];
}

List<BoxShadow> lightShadow(ThemeData theme) {
  return <BoxShadow>[
    BoxShadow(
      color: textColor.withOpacity(0.05),
      blurRadius: 25,
      spreadRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
}

List<BoxShadow> bottomBarShadow(ThemeData theme) {
  return <BoxShadow>[
    BoxShadow(
        color: textColor.withOpacity(0.05),
        offset: const Offset(0, -4),
        blurRadius: 15),
  ];
}
