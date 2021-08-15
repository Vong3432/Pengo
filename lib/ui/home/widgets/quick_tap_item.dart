import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/ui/penger/info_view.dart';

class QuickTapItem extends StatelessWidget {
  const QuickTapItem(
      {Key? key, required this.title, this.onTap, required this.assetName})
      : super(key: key);

  final String title;
  final String assetName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: primaryLightColor,
              // boxShadow: normalShadow(Theme.of(context)),
              shape: BoxShape.circle,
            ),
            width: 65,
            height: 65,
            child: SvgPicture.asset(
              assetName,
              width: 27,
              height: 27,
              fit: BoxFit.scaleDown,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              title,
              style: PengoStyle.caption(context),
            ),
          ),
        ],
      ),
    );
  }
}
