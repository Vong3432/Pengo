import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pengo/config/theme.dart';
import 'package:pengo/helpers/notification/push_notification_manager.dart';
import 'package:pengo/providers/multi_bloc_provider.dart';
import 'package:pengo/splash.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  await PushNotificationManager().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengo',
      theme: themeData,
      home: const Splash(),
    );
  }
}
