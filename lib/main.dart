import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pengo/config/theme.dart';
import 'package:pengo/helpers/geo/geo_helper.dart';
import 'package:pengo/helpers/notification/push_notification_manager.dart';
import 'package:pengo/models/providers/auth_model.dart';
import 'package:pengo/providers/booking_pass_provider.dart';
import 'package:pengo/providers/multi_bloc_provider.dart';
import 'package:pengo/splash.dart';
import 'package:pengo/ui/penger/items/item_info_view.dart';
import 'package:provider/provider.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await dotenv.load(fileName: ".env");
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  await PushNotificationManager().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: multiBlocProviders(context),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BookingPassModel()),
          ChangeNotifierProvider(create: (_) => AuthModel()),
          ChangeNotifierProvider(create: (_) => GeoHelper()),
        ],
        child: MaterialApp(
          title: 'Pengo',
          theme: themeData,
          routes: {
            "/booking-item": (context) => ItemInfoView(),
          },
          home: const Splash(),
        ),
      ),
    );
  }
}
