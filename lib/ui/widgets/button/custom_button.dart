import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/helpers/theme/custom_font.dart';

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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: minimumSize?.width ?? double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor ?? primaryColor,
          boxShadow: normalShadow(Theme.of(context)),
        ),
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: PengoStyle.title(context).copyWith(
            color: whiteColor,
          ),
          child: text,
        ),
      ),
    );
    // return ElevatedButton(
    //   style: ElevatedButton.styleFrom(
    //     textStyle:
    //         PengoStyle.body(context).copyWith(fontWeight: FontWeight.w600),
    //     primary: backgroundColor ?? primaryColor,
    //     onPrimary: color ?? Colors.white,
    //     minimumSize: minimumSize ?? const Size(double.infinity, 48),
    //   ),
    //   onPressed: onPressed,
    //   child: text,
    // );
  }
}
