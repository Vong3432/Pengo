import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pengo/app.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/geo/geo_helper.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/ui/home/widgets/location_list.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';
import 'package:provider/src/provider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userLocation = context.watch<GeoHelper>().currentPos();
    final _userHasSetupLocation = _userLocation != null;

    return Scaffold(
      body: IntroductionScreen(
        pages: <PageViewModel>[
          PageViewModel(
            title: "Welcome to Pengo",
            decoration: PageDecoration(
              titleTextStyle: PengoStyle.navigationTitle(context),
              bodyFlex: 4,
              fullScreen: true,
            ),
            bodyWidget: Padding(
              padding: const EdgeInsets.only(top: 52.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    minLeadingWidth: 42,
                    leading: SvgPicture.asset(
                      ONBOARDING1_ICON_PATH,
                      color: primaryColor,
                      width: 32,
                      height: 32,
                      fit: BoxFit.fitWidth,
                    ),
                    title: Text(
                      "Standardized booking",
                      style: PengoStyle.title2(context),
                    ),
                    subtitle: Text(
                      "Discover and find places to book with fingertips.",
                      style: PengoStyle.smallerText(context).copyWith(
                        color: grayTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT,
                  ),
                  ListTile(
                    minLeadingWidth: 42,
                    leading: SvgPicture.asset(
                      COUPON_ICON_PATH,
                      color: primaryColor,
                      width: 32,
                      height: 32,
                      fit: BoxFit.fitWidth,
                    ),
                    title: Text(
                      "Coupon rewarding",
                      style: PengoStyle.title2(context),
                    ),
                    subtitle: Text(
                      "Get yourself to redeem coupons from the Penger while you are booking.",
                      style: PengoStyle.smallerText(context).copyWith(
                        color: grayTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT,
                  ),
                  ListTile(
                    minLeadingWidth: 42,
                    leading: SvgPicture.asset(
                      CARD_ICON_PATH,
                      width: 32,
                      height: 32,
                      color: primaryColor,
                      fit: BoxFit.fitWidth,
                    ),
                    title: Text(
                      "Digital Card",
                      style: PengoStyle.title2(context),
                    ),
                    subtitle: Text(
                      "Use your GooCard as a identity that let you use pass or coupons.",
                      style: PengoStyle.smallerText(context).copyWith(
                        color: grayTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          PageViewModel(
            title: "Setup your location",
            decoration: PageDecoration(
              titleTextStyle: PengoStyle.navigationTitle(context),
              bodyAlignment: Alignment.center,
              fullScreen: true,
              bodyFlex: 5,
            ),
            bodyWidget: Column(
              children: <Widget>[
                Text(
                  "For a better user-experience, we highly recommend to enable location access so that we can do:",
                  style: PengoStyle.text(context).copyWith(
                    color: secondaryTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 52,
                ),
                ListTile(
                  minLeadingWidth: 18,
                  leading: SvgPicture.asset(
                    LOCATION_ICON_PATH,
                    width: 18,
                    height: 18,
                    color: primaryColor,
                  ),
                  title: Text(
                    "Distance calculation",
                    style: PengoStyle.title2(context).copyWith(
                      color: grayTextColor,
                    ),
                  ),
                  subtitle: Text(
                    "To estimate the distance for you to be where you booked.",
                    style: PengoStyle.captionNormal(context).copyWith(
                      color: secondaryTextColor,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(
                  height: SECTION_GAP_HEIGHT,
                ),
                ListTile(
                  minLeadingWidth: 18,
                  leading: SvgPicture.asset(
                    LOCATION_ICON_PATH,
                    width: 18,
                    height: 18,
                    color: primaryColor,
                  ),
                  title: Text(
                    "App navigation",
                    style: PengoStyle.title2(context).copyWith(
                      color: grayTextColor,
                    ),
                  ),
                  subtitle: Text(
                    "We provide in-app navigation for you so that you can view the routes from your current location to the destination without leaving the app.",
                    style: PengoStyle.captionNormal(context).copyWith(
                      color: secondaryTextColor,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.only(top: 52.0),
              child: Column(
                children: [
                  CustomButton(
                    boxShadow: [],
                    onPressed: () {
                      if (_userHasSetupLocation) {
                        debugPrint("is setup");

                        // set seen so that onboarding will not show after this
                        // but for demo purpose, leave it comment first.
                        // SharedPreferences.getInstance().then((prefs) {
                        //   prefs.setBool('seen', true);
                        // });

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<Widget>(
                            builder: (BuildContext context) =>
                                const MyHomePage(),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute<Widget>(
                            builder: (BuildContext context) =>
                                const LocationList(),
                          ),
                        );
                      }
                    },
                    text:
                        Text(_userHasSetupLocation == false ? "Setup" : "Done"),
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT,
                  ),
                  Visibility(
                    visible: _userHasSetupLocation == false,
                    child: CustomButton(
                      backgroundColor: greyBgColor,
                      boxShadow: [],
                      color: secondaryTextColor,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<Widget>(
                            builder: (BuildContext context) =>
                                const MyHomePage(),
                          ),
                        );
                      },
                      text: const Text("Skip"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        showNextButton: false,
        // isProgress: false,
        showDoneButton: false,
        dotsDecorator: DotsDecorator(
          color: textColor.withOpacity(0.3),
          activeColor: primaryColor,
        ),
        onDone: () {
          // When done button is press
        },
      ),
    );
  }
}
