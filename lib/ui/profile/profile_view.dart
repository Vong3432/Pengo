import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/models/auth_model.dart';
import 'package:pengo/models/providers/auth_model.dart';
import 'package:pengo/ui/auth/login_view.dart';
import 'package:pengo/ui/profile/profile_info.dart';
import 'package:pengo/ui/profile/setting_view.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:pengo/ui/widgets/list/custom_list_item.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Auth? _user;

  @override
  void initState() {
    // TODO: implement initState
    // SharedPreferencesHelper().getKey("user").then((value) {
    //   if (value != null) {
    //     setState(() {
    //       _user = Auth.fromJson(_user);
    //     });
    //   }
    // });
    super.initState();
  }

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
                    Consumer<AuthModel>(builder: (builder, authModel, _) {
                      return authModel.user == null
                          ? Container()
                          : _buildLoggedInView(context);
                    }),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoggedInView(BuildContext context) {
    return Column(
      children: [
        _buildAccountSection(context),
        _buildActionSection(context),
      ],
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
          onTap: () {
            context.read<AuthModel>().logoutUser();
          },
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
    bool isGuest = context.watch<AuthModel>().user == null;
    return GestureDetector(
      onTap: () {
        isGuest
            ? Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(builder: (context) => LoginPage()),
              )
            : Navigator.of(context, rootNavigator: true).push(
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
            if (context.watch<AuthModel>().user != null &&
                context.watch<AuthModel>().user!.avatar.contains("dicebear"))
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  // border: Border.all(width: 2.5, color: greyBgColor),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.network(
                  context.watch<AuthModel>().user!.avatar,
                  width: 27,
                  fit: BoxFit.cover,
                ),
              )
            else
              CircleAvatar(
                minRadius: 27,
                backgroundImage: NetworkImage(
                  context.watch<AuthModel>().user == null
                      ? "https://res.cloudinary.com/dpjso4bmh/image/upload/v1626867341/pengo/penger/staff/3192c5a13626653bffeb2c1171df716f_wrchju.png"
                      : context.watch<AuthModel>().user!.avatar,
                ),
              ),
            const SizedBox(
              width: SECTION_GAP_HEIGHT,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  context.watch<AuthModel>().user == null
                      ? 'Guest user'
                      : context.watch<AuthModel>().user!.username,
                  style: PengoStyle.header(context),
                ),
                Text(
                  context.watch<AuthModel>().user == null
                      ? "Click to sign in"
                      : context.watch<AuthModel>().user!.phone,
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
