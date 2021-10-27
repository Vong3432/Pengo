import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pengo/const/lottie_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';

class LoginUserOnly extends StatelessWidget {
  const LoginUserOnly({
    Key? key,
    required this.text,
    this.lottie,
  }) : super(key: key);

  final String text;
  final String? lottie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset(
              lottie ?? LOGIN_USER_ONLY_LOTTIE,
              width: 200,
              height: 200,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(
              height: SECTION_GAP_HEIGHT,
            ),
            Text(
              text,
              style: PengoStyle.header(context),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
