import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/library.dart';

class MapView extends StatefulWidget {
  const MapView({
    Key? key,
    this.initialLat,
    this.initialLng,
    required this.bookingLat,
    required this.bookingLng,
    required this.destinationName,
  }) : super(key: key);

  final double? initialLat;
  final double? initialLng;

  // not using a list since i dont decide to add multiple waypoints
  final double bookingLat;
  final double bookingLng;

  final String destinationName;

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  String _platformVersion = 'Unknown';
  String? _instruction = "";
  late MapBoxNavigation _directions;
  MapBoxOptions? _options;

  bool _isMultipleStop = false;
  double _distanceRemaining = 0;
  double _durationRemaining = 0;
  late MapBoxNavigationViewController _controller;
  bool _routeBuilt = false;
  bool _isNavigating = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(),
      ),
      body: Center(
        child: Column(children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                // Text('Running on: $_platformVersion\n'),
                // Container(
                //   color: Colors.grey,
                //   width: double.infinity,
                //   child: Padding(
                //     padding: EdgeInsets.all(10),
                //     child: (Text(
                //       "Full Screen Navigation",
                //       style: TextStyle(color: Colors.white),
                //       textAlign: TextAlign.center,
                //     )),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text("Open map"),
                      onPressed: () async {
                        var wayPoints = <WayPoint>[];
                        wayPoints.add(
                          WayPoint(
                            name: "Current",
                            latitude: widget.initialLat,
                            longitude: widget.initialLng,
                          ),
                        );
                        wayPoints.add(
                          WayPoint(
                            name: widget.destinationName,
                            latitude: widget.bookingLat,
                            longitude: widget.bookingLng,
                          ),
                        );

                        _directions.startNavigation(
                          wayPoints: wayPoints,
                          options: MapBoxOptions(
                            mode: MapBoxNavigationMode.drivingWithTraffic,
                            simulateRoute: false,
                            language: "en",
                            units: VoiceUnits.metric,
                          ),
                        );
                      },
                    ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // ElevatedButton(
                    //   child: Text("Start Multi Stop"),
                    //   onPressed: () async {
                    //     _isMultipleStop = true;
                    //     var wayPoints = <WayPoint>[];
                    //     wayPoints.add(_origin);
                    //     wayPoints.add(_stop1);
                    //     wayPoints.add(_stop2);
                    //     wayPoints.add(_stop3);
                    //     wayPoints.add(_stop4);
                    //     wayPoints.add(_origin);

                    //     await _directions.startNavigation(
                    //         wayPoints: wayPoints,
                    //         options: MapBoxOptions(
                    //             mode: MapBoxNavigationMode.driving,
                    //             simulateRoute: true,
                    //             language: "en",
                    //             allowsUTurnAtWayPoints: true,
                    //             units: VoiceUnits.metric));
                    //   },
                    // )
                  ],
                ),
                // Container(
                //   color: Colors.grey,
                //   width: double.infinity,
                //   child: Padding(
                //     padding: EdgeInsets.all(10),
                //     child: (Text(
                //       _instruction == null || _instruction?.isEmpty == true
                //           ? "Banner Instruction Here"
                //           : _instruction.toString(),
                //       style: TextStyle(color: Colors.white),
                //       textAlign: TextAlign.center,
                //     )),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20, top: 20, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("Duration Remaining: "),
                          Text(_durationRemaining != null
                              ? "${(_durationRemaining / 60).toStringAsFixed(0)} minutes"
                              : "---")
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Distance Remaining: "),
                          Text(_distanceRemaining != null
                              ? "${(_distanceRemaining * 0.000621371).toStringAsFixed(1)} miles"
                              : "---")
                        ],
                      ),
                    ],
                  ),
                ),
                // Divider()
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey,
              child: MapBoxNavigationView(
                options: _options,
                onRouteEvent: _onEmbeddedRouteEvent,
                onCreated: (MapBoxNavigationViewController controller) async {
                  _controller = controller;
                  controller.initialize();
                },
              ),
            ),
          )
        ]),
      ),
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);

    _options = MapBoxOptions(
      initialLatitude: widget.initialLat,
      initialLongitude: widget.initialLng,
      zoom: 15.0,
      tilt: 0.0,
      bearing: 0.0,
      enableRefresh: false,
      alternatives: true,
      voiceInstructionsEnabled: true,
      bannerInstructionsEnabled: true,
      allowsUTurnAtWayPoints: true,
      mode: MapBoxNavigationMode.drivingWithTraffic,
      units: VoiceUnits.imperial,
      simulateRoute: false,
      animateBuildRoute: true,
      longPressDestinationEnabled: true,
      language: "en",
    );

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await _directions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _onEmbeddedRouteEvent(e) async {
    _distanceRemaining = await _directions.distanceRemaining;
    _durationRemaining = await _directions.durationRemaining;

    debugPrint("event ${e.eventType}");

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        final RouteProgressEvent progressEvent = e.data as RouteProgressEvent;
        if (progressEvent.currentStepInstruction != null)
          _instruction = progressEvent.currentStepInstruction;
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {
          _routeBuilt = true;
        });
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {
          _routeBuilt = false;
        });
        break;
      case MapBoxEvent.navigation_running:
        setState(() {
          _isNavigating = true;
        });
        break;
      case MapBoxEvent.on_arrival:
        if (!_isMultipleStop) {
          await Future.delayed(Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {
          _routeBuilt = false;
          _isNavigating = false;
        });
        break;
      default:
        break;
    }
    setState(() {});
  }
}
