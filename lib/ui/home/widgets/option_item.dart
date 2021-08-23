import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';

class OptionItem extends StatelessWidget {
  const OptionItem({
    Key? key,
    required this.assetName,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String assetName;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: primaryLightColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned.fill(
              child: Align(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      assetName,
                      width: 72,
                      height: 72,
                      fit: BoxFit.scaleDown,
                    ),
                    Text(
                      title,
                      style: PengoStyle.caption(context),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
