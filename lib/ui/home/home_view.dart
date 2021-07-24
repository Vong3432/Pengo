import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pengo/ui/home/widgets/home_h_listview.dart';
import 'package:pengo/ui/home/widgets/penger_item.dart';
import 'package:pengo/ui/home/widgets/quick_tap_item.dart';
import 'package:pengo/ui/home/widgets/self_booking_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height * 0.05,
          backgroundColor: Colors.white,
          pinned: true,
          centerTitle: false,
          title: const Text(
            "Find & Book",
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.location_on_outlined),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Text(
                        "Current location",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Gelang Patah, Johor",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
          actionsIconTheme: const IconThemeData(color: Colors.black),
          textTheme: TextTheme(headline1: Typography.blackCupertino.headline1),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  CupertinoSearchTextField(
                    onChanged: (String value) {
                      debugPrint('The text has changed to: $value');
                    },
                    onSubmitted: (String value) {
                      debugPrint('Submitted text: $value');
                    },
                  ),
                  const QuickTapSection(),
                  HomeHListView(
                    textTheme: textTheme,
                    title: "My Booking",
                    children: <Widget>[
                      SelfBookingItem(textTheme: textTheme),
                      SelfBookingItem(textTheme: textTheme),
                      SelfBookingItem(textTheme: textTheme),
                    ],
                  ),
                  HomeHListView(
                    textTheme: textTheme,
                    title: "Popular",
                    children: const <Widget>[
                      PengerItem(),
                      PengerItem(),
                      PengerItem(),
                      PengerItem(),
                      PengerItem(),
                    ],
                  ),
                  HomeHListView(
                    textTheme: textTheme,
                    title: "Nearby you",
                    children: <Widget>[
                      PengerItem(),
                      PengerItem(),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      debugPrint("${Future.error('Location services are disabled.')}");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        debugPrint("${Future.error('Location permissions are denied')}");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      debugPrint(
          "${Future.error('Location permissions are permanently denied, we cannot request permissions.')}");
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    debugPrint("Position: ${position.toString()}");
  }
}

class QuickTapSection extends StatelessWidget {
  const QuickTapSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const Text(
              "Quick Tap",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <QuickTapItem>[
            QuickTapItem(),
            QuickTapItem(),
            QuickTapItem(),
            QuickTapItem()
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Divider(),
        )
      ],
    );
  }
}
