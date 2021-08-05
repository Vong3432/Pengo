import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/helpers/notification/push_notification_manager.dart';
import 'package:pengo/helpers/routes/route.dart';
import 'package:pengo/ui/goocard/goocard_view.dart';
import 'package:pengo/ui/home/home_view.dart';
import 'package:pengo/ui/profile/profile_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  // final _navigatorKey = GlobalKey<NavigatorState>();
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  void _onBottomNavItemTapped(int idx) {
    Widget screen;
    switch (idx) {
      case 0:
        // home
        screen = const HomePage();
        // _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
        break;
      case 1:
        // goocard
        screen = const GooCardPage();
        // _navigatorKey.currentState!
        //     .pushNamedAndRemoveUntil('/goocard', (_) => false);
        break;
      case 2:
        // history
        screen = const HomePage();
        // _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
        break;
      case 3:
        // profile
        screen = const ProfilePage();
        // _navigatorKey.currentState!
        //     .pushNamedAndRemoveUntil('/profile', (_) => false);
        break;
      default:
        screen = const HomePage();
      // _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
    }

    setState(() {
      currentScreen = screens[idx];
      _selectedIndex = idx;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: PageStorage(bucket: bucket, child: currentScreen),
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: textColor,
        currentIndex: _selectedIndex,
        selectedBackgroundColor: Colors.transparent,
        borderRadius: 50,
        iconSize: 27,
        selectedItemColor: Colors.white,
        onTap: _onBottomNavItemTapped,
        items: <FloatingNavbarItem>[
          FloatingNavbarItem(
            customWidget: navIcon(_selectedIndex == 0, Icons.home_outlined),
          ),
          FloatingNavbarItem(
            customWidget: navIcon(_selectedIndex == 1, Icons.credit_card),
          ),
          FloatingNavbarItem(
            customWidget:
                navIcon(_selectedIndex == 2, Icons.calendar_today_outlined),
          ),
          FloatingNavbarItem(
            customWidget: navIcon(_selectedIndex == 3, Icons.person_outlined),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // ignore: avoid_positional_boolean_parameters
  Stack navIcon(bool show, IconData icon) {
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
          child: Icon(
            icon,
            size: 27,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
