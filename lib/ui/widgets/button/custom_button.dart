import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/ui/widgets/api/loading.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.backgroundColor,
    this.color,
    this.minimumSize,
    this.isLoading,
    this.padding,
    this.border,
    this.boxShadow,
    this.fullWidth = true,
    this.radius,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget text;
  final Color? backgroundColor;
  final Color? color;
  final double? minimumSize;
  final bool? isLoading;
  final EdgeInsets? padding;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final bool? fullWidth;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const LoadingWidget()
        : GestureDetector(
            onTap: onPressed,
            child: Container(
              width: fullWidth == true ? double.infinity : null,
              padding: padding ?? const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: border,
                borderRadius: BorderRadius.circular(radius ?? 15),
                color: backgroundColor ?? primaryColor,
                boxShadow: boxShadow ?? normalShadow(Theme.of(context)),
              ),
              child: DefaultTextStyle(
                textAlign: TextAlign.center,
                style: PengoStyle.title(context).copyWith(
                  color: color ?? whiteColor,
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
