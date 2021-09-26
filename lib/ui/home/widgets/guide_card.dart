import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/const/graphic_const.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';

class GuideCard extends StatelessWidget {
  const GuideCard({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaQuery(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: lightShadow(
          Theme.of(context),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: color,
                ),
                Positioned.fill(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        G1_GRAPHIC_PNG,
                        filterQuality: FilterQuality.medium,
                        fit: BoxFit.scaleDown,
                      )),
                ),
                Positioned.fill(
                  right: 20,
                  top: 20,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SvgPicture.asset(
                          EYE_ICON_PATH,
                          width: 18,
                          color: whiteColor,
                          fit: BoxFit.scaleDown,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "2m read",
                            style: PengoStyle.caption(context).copyWith(
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Getting Started?",
                    style: PengoStyle.title(context),
                  ),
                  Text(
                    "Lorem ipsum is placeholder text commonly used in the graphic ... ",
                    style: PengoStyle.text(context).copyWith(
                      color: secondaryTextColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT,
                  ),
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        SHIELD_ICON_PATH,
                        width: 21,
                        fit: BoxFit.scaleDown,
                        color: successColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Beginner",
                          style: PengoStyle.caption(context).copyWith(
                            color: successColor,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
