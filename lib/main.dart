import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:flutter/material.dart';
import 'package:pengo/helpers/notification/push_notification_manager.dart';
import 'package:pengo/onboarding.dart';
import 'package:pengo/ui/home/home_view.dart';
import 'package:pengo/ui/penger/booking/booking_cubit.dart';
import 'package:pengo/ui/penger/booking/booking_state.dart';
import 'package:pengo/ui/profile/profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  await PushNotificationManager().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => BookingCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: primaryColor,
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Poppins',
          dividerColor: Colors.black38,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 28,
              fontFamily: 'Poppins',
              letterSpacing: -1,
              fontWeight: FontWeight.bold,
            ),
            headline2: TextStyle(
              fontSize: 26,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
            headline3: TextStyle(
              fontSize: 24,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
            headline4: TextStyle(
              fontSize: 22,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
            headline5: TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
            headline6: TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
            subtitle1: TextStyle(fontFamily: 'Work Sans'),
            subtitle2: TextStyle(fontFamily: 'Work Sans'),
            caption: TextStyle(fontFamily: 'Work Sans'),
          ).apply(
            bodyColor: textColor,
            displayColor: textColor,
          ),
          platform: TargetPlatform.iOS,
        ),
        // home: const HomePage(), //Material App,
        home: const Splash(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future<void> checkFirstSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool _seen = prefs.getBool('seen') ?? true; // default: false

    if (_seen) {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(
          builder: (BuildContext context) => const MyHomePage()));
    } else {
      // Set the flag to true at the end of onboarding screen if everything is successfull and so I am commenting it out
      // await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(CupertinoPageRoute(
          builder: (BuildContext context) => const OnboardingPage()));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CircularProgressIndicator());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final _navigatorKey = GlobalKey<NavigatorState>();

  void _onBottomNavItemTapped(int idx) {
    switch (idx) {
      case 0:
        _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
        break;
      case 1:
        _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
        break;
      case 2:
        _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
        break;
      case 3:
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
            WidgetBuilder builder;
            // Manage your route names here
            switch (settings.name) {
              case '/':
                builder = (BuildContext context) => HomePage();
                break;
              case '/goocard':
                builder = (BuildContext context) => HomePage();
                break;
              case '/history':
                builder = (BuildContext context) => HomePage();
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
