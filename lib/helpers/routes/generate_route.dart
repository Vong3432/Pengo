import 'package:flutter/cupertino.dart';
import 'package:pengo/ui/home/home_view.dart';
import 'package:pengo/ui/profile/profile_view.dart';

Route<dynamic> generateAppRoute(RouteSettings settings) {
  WidgetBuilder builder;
  // Manage your route names here
  switch (settings.name) {
    case '/':
      builder = (BuildContext context) => const HomePage();
      break;
    case '/goocard':
      builder = (BuildContext context) => const HomePage();
      break;
    case '/history':
      builder = (BuildContext context) => const HomePage();
      break;
    case '/profile':
      builder = (BuildContext context) => const ProfilePage();
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
}
