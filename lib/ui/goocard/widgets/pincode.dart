import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class GooCardPinCode extends StatelessWidget {
  const GooCardPinCode({
    Key? key,
    required this.controller,
    this.onTextChanged,
    this.onDone,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String)? onTextChanged;
  final Function(String)? onDone;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      autofocus: true,
      controller: controller,
      defaultBorderColor: greyBgColor,
      hasTextBorderColor: primaryColor,
      pinBoxWidth: 52,
      pinBoxHeight: 52,
      maxLength: 6,
      onTextChanged: onTextChanged,
      onDone: onDone,
      wrapAlignment: WrapAlignment.spaceAround,
      pinTextStyle: PengoStyle.header(context),
      pinBoxRadius: 12,
      pinTextAnimatedSwitcherTransition:
          ProvidedPinBoxTextAnimation.defaultNoTransition,
      // pinBoxColor: Colors.green[100],
      // pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
      // highlightAnimation: true,
      highlightAnimationBeginColor: Colors.black,
      highlightAnimationEndColor: Colors.white12,
    );
  }
}
