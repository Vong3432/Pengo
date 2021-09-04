import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText,
    this.onChanged,
    this.obsecureText,
    this.readOnly,
    this.inputType,
    this.inputAction,
    this.validator,
    this.controller,
    this.lblStyle,
    this.contentPadding,
    this.decoration,
    this.inputFormatters,
    this.isOptional,
    this.sideNote,
    this.onSaved,
    this.onEditingComplete,
    this.error,
  }) : super(key: key);

  final String label;
  final String hintText;
  final void Function(String value)? onChanged;
  final void Function(String? value)? onSaved;
  final void Function()? onEditingComplete;
  final bool? obsecureText;
  final bool? readOnly;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextStyle? lblStyle;
  final EdgeInsetsGeometry? contentPadding;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isOptional;
  final Text? sideNote;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              label,
              style: lblStyle ??
                  PengoStyle.title2(context).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            if (isOptional == true)
              Text(
                "(optional)",
                style: PengoStyle.subcaption(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor.withOpacity(0.5),
                ),
              )
            else
              Container()
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Container(
              height: 52,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.5,
                  color: greyBgColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            TextFormField(
              onEditingComplete: onEditingComplete,
              controller: controller,
              validator: validator,
              onFieldSubmitted: onSaved,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: obsecureText ?? false,
              onChanged: onChanged,
              readOnly: readOnly ?? false,
              textInputAction: inputAction,
              keyboardType: inputType,
              inputFormatters: inputFormatters,
              decoration: decoration == null
                  ? InputDecoration(
                      hintText: hintText,
                      contentPadding: contentPadding,
                    )
                  : decoration,
            ),
          ],
        ),
        sideNote ?? Container(),
        error == null || error?.isEmpty == true
            ? Container()
            : Text(
                error!,
                style: PengoStyle.smallerText(context).copyWith(
                  color: dangerColor,
                ),
              ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
      ],
    );
  }
}
