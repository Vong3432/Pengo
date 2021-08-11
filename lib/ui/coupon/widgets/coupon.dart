import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';

class Coupon extends StatelessWidget {
  const Coupon({
    Key? key,
    required this.name,
    required this.pengerName,
    required this.date,
    this.minimumCp,
    this.isRedeemed,
  }) : super(key: key);

  final String name;
  final String pengerName;
  final String date;
  final String? minimumCp;
  final bool? isRedeemed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: normalShadow(
          Theme.of(context),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: PengoStyle.title(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT - 8,
                  ),
                  Text(
                    pengerName,
                    style: PengoStyle.caption(context)
                        .copyWith(color: secondaryTextColor),
                  ),
                  Text(
                    date,
                    style: PengoStyle.captionNormal(context)
                        .copyWith(color: secondaryTextColor),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: mediaQuery(context).size.width * 0.35,
              decoration: BoxDecoration(
                gradient: primaryLinear,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "MIN",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    Text(
                      "${minimumCp ?? 0}CP",
                      style: PengoStyle.title(context)
                          .copyWith(color: Colors.white),
                    ),
                    _generateBtn()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _generateBtn() {
    return CustomButton(
      onPressed: isRedeemed == true ? null : _onCouponPressed,
      color: Colors.white,
      backgroundColor: textColor,
      minimumSize: const Size(double.infinity, 30),
      text: Text(
        isRedeemed == true ? "Redeemed" : "Redeem",
        maxLines: 1,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  void _onCouponPressed() {}
}
