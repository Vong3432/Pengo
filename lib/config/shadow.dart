import 'package:flutter/material.dart';
import 'color.dart';

List<BoxShadow> normalShadow(ThemeData theme) {
  return <BoxShadow>[
    BoxShadow(
        color: theme.primaryColor.withOpacity(0.05),
        offset: const Offset(0, 4),
        blurRadius: 15),
    BoxShadow(
      color: textColor.shade100,
      blurRadius: 25,
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
