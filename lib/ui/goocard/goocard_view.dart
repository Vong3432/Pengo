import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/ui/goocard/widgets/goocard.dart';
import 'package:pengo/ui/home/widgets/quick_tap_item.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';

class GooCardPage extends StatelessWidget {
  const GooCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            title: Text(
              "Card",
              style: textTheme(context).headline1,
            ),
          ),
          CustomSliverBody(content: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: ListView(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      QuickTapItem(),
                      QuickTapItem(),
                      QuickTapItem(),
                    ],
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT + 18,
                  ),
                  const GooCard(),
                  _buildCreditHistory(context)
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildCreditHistory(BuildContext context) {
    final histories = [
      ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Container(
          width: 42,
          height: 42,
          color: primaryColor.shade50,
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(COUPON_ICON_PATH),
        ),
        title: Text(
          "Used Ticket A",
          style: PengoStyle.caption(context),
        ),
        subtitle: Text(
          "1 Jul 2021 03:00PM",
          style: PengoStyle.subcaption(context),
        ),
        trailing: Text(
          "+ 100",
          style: TextStyle(
              fontSize: 12, color: successColor, fontWeight: FontWeight.w600),
        ),
      ),
      ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Container(
          width: 42,
          height: 42,
          color: primaryColor.shade50,
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(GOOCARD_ICON_PATH),
        ),
        title: Text(
          "Redeemed Coupon A",
          style: PengoStyle.caption(context),
        ),
        subtitle: Text(
          "1 Jul 2021 03:00PM",
          style: PengoStyle.subcaption(context),
        ),
        trailing: Text(
          "- 100",
          style: TextStyle(
              fontSize: 12, color: dangerColor, fontWeight: FontWeight.w600),
        ),
      )
    ];

    return Column(
      children: [
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Credits History",
              style: PengoStyle.title(context),
            ),
            const Spacer(),
            const Text(
              "See all",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            )
          ],
        ),
        const Divider(),
        ...histories,
      ],
    );
  }
}
