import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pengo/app.dart';
import 'package:pengo/helpers/storage/shared_preferences_helper.dart';
import 'package:pengo/models/auth_model.dart';
import 'package:pengo/models/providers/auth_model.dart';
import 'package:pengo/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future<void> checkFirstSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _user = await SharedPreferencesHelper().getKey("user");
    final bool _seen = prefs.getBool('seen') ?? true; // default: false

    if (_user != null) {
      final Map<String, dynamic> decoded =
          jsonDecode(_user) as Map<String, dynamic>;

      final Auth u = Auth(
          username: decoded['username'].toString(),
          id: decoded['id'] as int,
          avatar: decoded['avatar'].toString(),
          phone: decoded['phone'].toString(),
          token: decoded['token'].toString(),
          email: decoded['email'].toString());

      context.read<AuthModel>().setUser(u);
    }

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
