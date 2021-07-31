import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.backgroundColor,
    this.color,
    this.minimumSize,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget text;
  final Color? backgroundColor;
  final Color? color;
  final Size? minimumSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: backgroundColor ?? textColor,
        onPrimary: backgroundColor ?? Colors.white,
        minimumSize: minimumSize ?? const Size(double.infinity, 48),
      ),
      onPressed: onPressed,
      child: text,
    );
  }
}
