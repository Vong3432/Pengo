import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/helpers/notification/push_notification_manager.dart';
import 'package:pengo/helpers/routes/route.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/ui/goocard/goocard_view.dart';
import 'package:pengo/ui/home/home_view.dart';
import 'package:pengo/ui/penger/items/item_info_view.dart';
import 'package:pengo/ui/profile/profile_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.idx}) : super(key: key);

  final int? idx;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final _navigatorKey = GlobalKey<NavigatorState>();

  void _onBottomNavItemTapped(int idx) {
    switch (idx) {
      case 0:
        // home
        // screen = const HomePage();
        _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
        break;
      case 1:
        // goocard
        // screen = const GooCardPage();
        _navigatorKey.currentState!
            .pushNamedAndRemoveUntil('/goocard', (_) => false);
        break;
      case 2:
        // history
        _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
        break;
      case 3:
        // history
        _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
        break;
      case 4:
        // profile
        _navigatorKey.currentState!
            .pushNamedAndRemoveUntil('/profile', (_) => false);
        break;
      default:
        _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
    }

    setState(() {
      _selectedIndex = idx;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.idx != null) {
      setState(() {
        _selectedIndex = widget.idx!;
      });
    }

    PushNotificationManager().init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      extendBody: true,
      body: WillPopScope(
        onWillPop: () async {
          if (_navigatorKey.currentState!.canPop()) {
            _navigatorKey.currentState!.pop();
            return false;
          }
          return true;
        },
        child: Navigator(
          key: _navigatorKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            debugPrint("Generating ${settings.name}");
            WidgetBuilder builder;
            // Manage your route names here
            switch (settings.name) {
              case '/':
                builder = (BuildContext context) => HomePage();
                break;
              case '/goocard':
                builder = (BuildContext context) => GooCardPage();
                break;
              case '/profile':
                builder = (BuildContext context) => ProfilePage();
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
            }
            // You can also return a PageRouteBuilder and
            // define custom transitions between pages
            return CupertinoPageRoute(
              builder: builder,
              settings: settings,
            );
          },
        ),
      ),
      bottomNavigationBar: DotNavigationBar(
        backgroundColor: whiteColor,
        currentIndex: _selectedIndex,
        borderRadius: 50,
        paddingR: const EdgeInsets.all(8),
        itemPadding: const EdgeInsets.all(8),
        dotIndicatorColor: Colors.transparent,
        boxShadow: normalShadow(Theme.of(context)),
        marginR: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        onTap: _onBottomNavItemTapped,
        items: <DotNavigationBarItem>[
          DotNavigationBarItem(
            selectedColor: primaryColor,
            icon: navIcon(_selectedIndex == 0, HOME_ICON_PATH),
          ),
          DotNavigationBarItem(
            selectedColor: primaryColor,
            icon: navIcon(_selectedIndex == 1, CARD_ICON_PATH),
          ),
          DotNavigationBarItem(
            selectedColor: primaryColor,
            icon: navIcon(_selectedIndex == 2, SCAN_ICON_PATH),
          ),
          DotNavigationBarItem(
            selectedColor: primaryColor,
            icon: navIcon(_selectedIndex == 3, CALENDAR_ICON_PATH),
          ),
          DotNavigationBarItem(
            selectedColor: primaryColor,
            icon: navIcon(_selectedIndex == 4, PROFILE_ICON_PATH),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // ignore: avoid_positional_boolean_parameters
  Stack navIcon(bool show, String icon) {
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor,
              ),
              width: show ? 8 : 0,
              height: show ? 8 : 0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: SvgPicture.asset(icon, width: 27, color: textColor),
        ),
      ],
    );
  }
}
