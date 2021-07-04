import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.05,
            backgroundColor: Colors.white,
            pinned: true,
            centerTitle: false,
            title: const Text(
              "Home",
              style: TextStyle(color: Colors.black),
            ),
            actions: <IconButton>[
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.qr_code_scanner_outlined),
              )
            ],
            actionsIconTheme: const IconThemeData(color: Colors.black),
            textTheme:
                TextTheme(headline1: Typography.blackCupertino.headline1),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    const Text('This is home page.'),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
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
