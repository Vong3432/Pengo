import 'package:flutter/material.dart';
import 'package:pengo/helpers/theme/custom_font.dart';

class ErrorResultWidget extends StatelessWidget {
  const ErrorResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Something went wrong",
      style: PengoStyle.text(context),
    );
  }
}
