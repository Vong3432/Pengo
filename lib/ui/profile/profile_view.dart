import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/ui/profile/profile_info.dart';
import 'package:pengo/ui/profile/setting_view.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:pengo/ui/widgets/list/custom_list_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            title: Text(
              "Profile",
              style: PengoStyle.navigationTitle(context),
            ),
          ),
          CustomSliverBody(
            content: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: <Widget>[
                    _buildProfileInfo(context),
                    _buildAccountSection(context),
                    _buildActionSection(context)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: SECTION_GAP_HEIGHT * 1.5,
        ),
        Text(
          "Actions",
          style: PengoStyle.header(context),
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        CustomListItem(
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: primaryLightColor,
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(PROFILE_ICON_PATH, fit: BoxFit.scaleDown),
          ),
          content: <Widget>[
            Text(
              "Logout",
              style: PengoStyle.title2(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: SECTION_GAP_HEIGHT * 1.5,
        ),
        Text(
          "Account",
          style: PengoStyle.header(context),
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        CustomListItem(
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: primaryLightColor,
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(PROFILE_ICON_PATH, fit: BoxFit.scaleDown),
          ),
          content: <Widget>[
            Text(
              "Edit profile",
              style: PengoStyle.title2(context),
            ),
            Text(
              "Update personal info",
              style: PengoStyle.smallerText(context)
                  .copyWith(color: grayTextColor),
            ),
          ],
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        CustomListItem(
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: primaryLightColor,
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(COUPON_ICON_PATH, fit: BoxFit.scaleDown),
          ),
          content: <Widget>[
            Text(
              "My rewards",
              style: PengoStyle.title2(context),
            ),
            Text(
              "View vouchers",
              style: PengoStyle.smallerText(context)
                  .copyWith(color: grayTextColor),
            ),
          ],
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        CustomListItem(
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: primaryLightColor,
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(REPORT_ICON_PATH, fit: BoxFit.scaleDown),
          ),
          content: <Widget>[
            Text(
              "Feedback",
              style: PengoStyle.title2(context),
            ),
            Text(
              "Report defects or suggestion",
              style: PengoStyle.smallerText(context)
                  .copyWith(color: grayTextColor),
            ),
          ],
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        CustomListItem(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute(builder: (context) => SettingView()),
            );
          },
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: primaryLightColor,
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(SETTING_ICON_PATH, fit: BoxFit.scaleDown),
          ),
          content: <Widget>[
            Text(
              "Setting",
              style: PengoStyle.title2(context),
            ),
            Text(
              "Configure in-app setting",
              style: PengoStyle.smallerText(context)
                  .copyWith(color: grayTextColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute(builder: (context) => ProfileInfoView()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        height: 100,
        decoration: BoxDecoration(
          color: greyBgColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: <Widget>[
            const CircleAvatar(
              minRadius: 27,
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80"),
            ),
            const SizedBox(
              width: SECTION_GAP_HEIGHT,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "John Doe",
                  style: PengoStyle.header(context),
                ),
                Text(
                  "012-3456789",
                  style: PengoStyle.text(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
