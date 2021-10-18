import 'package:flutter/material.dart';
import 'package:pengo/const/api_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';

class NoResultWidget extends StatelessWidget {
  const NoResultWidget({Key? key, this.msg}) : super(key: key);

  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Text(
      msg ?? NO_RESULT_MSG,
      style: PengoStyle.body(context),
    );
  }
}
