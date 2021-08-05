import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/const/logo_const.dart';
import 'package:pengo/const/shapes_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';

class GooCard extends StatelessWidget {
  const GooCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mediaQuery(context).size.height * 0.25,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: normalShadow(Theme.of(context)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Current Credits",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "300.00",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: PengoStyle.navigationTitle(context).fontSize,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(
                WAVE_SVG_PATH,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                GOOCARD_SVG_PATH,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
