import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/ui/home/booking_pass.dart';
import 'package:pengo/ui/home/widgets/option_item.dart';
import 'package:pengo/ui/home/widgets/quick_tap_item.dart';

class QuickTapSection extends StatelessWidget {
  const QuickTapSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <QuickTapItem>[
            QuickTapItem(
              title: "Scan",
              assetName: SCAN_ICON_PATH,
              onTap: () {
                showCupertinoModalBottomSheet(
                    useRootNavigator: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.all(18),
                        height: mediaQuery(context).size.height * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Use",
                              style: PengoStyle.header(context),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                OptionItem(
                                  assetName: GOOCARD_ICON_PATH,
                                  title: 'Booking Pass',
                                  onTap: () {
                                    showCupertinoModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return const BookingPassView();
                                        });
                                  },
                                ),
                                const SizedBox(width: 10),
                                OptionItem(
                                    assetName: COUPON_ICON_PATH,
                                    title: 'Coupon',
                                    onTap: () {}),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
            QuickTapItem(
              title: "FAQ",
              assetName: INFO_ICON_PATH,
              onTap: () {},
            ),
            QuickTapItem(
              title: "Coupons",
              assetName: COUPON_ICON_PATH,
              onTap: () {},
            ),
            QuickTapItem(
              title: "Feedback",
              assetName: REPORT_ICON_PATH,
              onTap: () {},
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
        )
      ],
    );
  }
}
