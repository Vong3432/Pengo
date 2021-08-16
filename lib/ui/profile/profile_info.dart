import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';

class ProfileInfoView extends StatefulWidget {
  const ProfileInfoView({Key? key}) : super(key: key);

  @override
  _ProfileInfoView createState() => _ProfileInfoView();
}

class _ProfileInfoView extends State<ProfileInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: Text(
              "Overview",
              style: PengoStyle.navigationTitle(context),
            ),
          ),
          CustomSliverBody(
            content: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: <Widget>[
                    _buildCreditPointInfo(context),
                    const SizedBox(
                      height: SECTION_GAP_HEIGHT,
                    ),
                    _buildMonthlyActivities(context),
                    const SizedBox(
                      height: SECTION_GAP_HEIGHT,
                    ),
                    _buildAllActivities(context)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Column _buildAllActivities(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "All activities",
          style: PengoStyle.title(context),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: greyBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: SvgPicture.asset(
              TICKET_ICON_PATH,
              width: 27,
              height: 27,
              color: textColor.withOpacity(0.5),
              fit: BoxFit.scaleDown,
            ),
            title: Text(
              "5",
              style: PengoStyle.header(context),
            ),
            subtitle: Text(
              "Booking records",
              style: PengoStyle.text(context),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: greyBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: SvgPicture.asset(
              COUPON_ICON_PATH,
              width: 27,
              height: 27,
              color: textColor.withOpacity(0.5),
              fit: BoxFit.scaleDown,
            ),
            title: Text(
              "0",
              style: PengoStyle.header(context),
            ),
            subtitle: Text(
              "Vouchers redeemed",
              style: PengoStyle.text(context),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildMonthlyActivities(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "This month",
          style: PengoStyle.title(context),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: greyBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: SvgPicture.asset(
              TICKET_ICON_PATH,
              width: 27,
              height: 27,
              color: textColor.withOpacity(0.5),
              fit: BoxFit.scaleDown,
            ),
            title: Text(
              "5",
              style: PengoStyle.header(context),
            ),
            subtitle: Text(
              "Booking records",
              style: PengoStyle.text(context),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: greyBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: SvgPicture.asset(
              COUPON_ICON_PATH,
              width: 27,
              height: 27,
              color: textColor.withOpacity(0.5),
              fit: BoxFit.scaleDown,
            ),
            title: Text(
              "0",
              style: PengoStyle.header(context),
            ),
            subtitle: Text(
              "Vouchers redeemed",
              style: PengoStyle.text(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreditPointInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "My credit points",
          style: PengoStyle.title(context),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            border: Border.all(color: greyBgColor, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "3000",
                      style: PengoStyle.title(context),
                    ),
                    Text(
                      "Available",
                      style: PengoStyle.caption(context),
                    ),
                  ],
                ),
                VerticalDivider(
                  thickness: 2.5,
                  color: greyBgColor,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "10000",
                      style: PengoStyle.title(context),
                    ),
                    Text(
                      "Total",
                      style: PengoStyle.caption(context),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
