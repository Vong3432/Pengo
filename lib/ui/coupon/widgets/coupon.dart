import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/ui/coupon/coupon_info_view.dart';

class Coupon extends StatelessWidget {
  const Coupon({
    Key? key,
    required this.name,
    required this.pengerName,
    required this.date,
    required this.id,
    this.minimumCp,
    this.isRedeemed,
    this.reload,
  }) : super(key: key);

  final String name;
  final String pengerName;
  final String date;
  final double? minimumCp;
  final bool? isRedeemed;
  final int id;
  final VoidCallback? reload;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onCouponPressed(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: normalShadow(
            Theme.of(context),
          ),
          color: Colors.white,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 18),
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
                        // const SizedBox(
                        //   height: 18,
                        // ),
                        // _generateBtn()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _generateBtn() {
  //   return CustomButton(
  //     onPressed: isRedeemed == true ? null : _onCouponPressed,
  //     color: Colors.white,
  //     padding: const EdgeInsets.all(4),
  //     backgroundColor: textColor,
  //     minimumSize: const Size(80, 30),
  //     text: Text(
  //       isRedeemed == true ? "Redeemed" : "Redeem",
  //       maxLines: 1,
  //       style: const TextStyle(fontSize: 11),
  //     ),
  //   );
  // }

  void _onCouponPressed(BuildContext context) {
    Navigator.of(context)
        .push(
      CupertinoPageRoute(
        builder: (BuildContext context) => CouponInfoView(
          id: id,
        ),
      ),
    )
        .then((_) {
      if (reload != null) {
        reload!();
      }
    });
  }
}
