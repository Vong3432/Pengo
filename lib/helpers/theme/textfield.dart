import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';

class PengoTheme {
  static InputDecorationTheme filled(BuildContext context) {
    return InputDecorationTheme(
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: greyBgColor,
    );
  }
}
