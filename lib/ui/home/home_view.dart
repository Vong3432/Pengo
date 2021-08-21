import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pengo/bloc/pengers/penger_bloc.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/socket/socket_helper.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/models/penger_model.dart';
import 'package:pengo/ui/home/widgets/home_h_listview.dart';
import 'package:pengo/ui/home/widgets/penger_item.dart';
import 'package:pengo/ui/home/widgets/quick_tap_item.dart';
import 'package:pengo/ui/home/widgets/self_booking_item.dart';
import 'package:pengo/ui/penger/info_view.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PengerBloc _pengerBloc;
  final SocketHelper _socketHelper = SocketHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _socketHelper.init();

    _pengerBloc = BlocProvider.of<PengerBloc>(context);
    _pengerBloc.add(const FetchPopularNearestPengers());

    _determinePosition();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _socketHelper.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return CustomScrollView(
      slivers: <Widget>[
        CustomSliverAppBar(
          title: Text(
            "Home",
            style: PengoStyle.navigationTitle(context),
          ),
          actions: [
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
        ),
        CustomSliverBody(
          content: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                  _buildUserBookingList(textTheme),
                  _buildQuickTapSection(textTheme),
                  _buildPopularList(context),
                  _buildNearbyList(context),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPopularList(BuildContext context) {
    return BlocBuilder<PengerBloc, PengerState>(
      builder: (BuildContext context, PengerState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: SECTION_GAP_HEIGHT),
            Text(
              "Popular",
              style: PengoStyle.header(context),
            ),
            if (state is NearestPopularPengersLoading)
              // Replace with skeleton loading
              _buildLoading(),
            if (state is NearestPopularPengersLoaded)
              _buildPopularPengers(state),
            if (state is NearestPopularPengersNotLoaded) _buildError()
          ],
        );
      },
    );
  }

  Text _buildError() => const Text("Something went wrong");

  ListView _buildPopularPengers(NearestPopularPengersLoaded state) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.poppularPengers.length,
      itemBuilder: (BuildContext ctx, int index) {
        final Penger penger = state.poppularPengers[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: PengerItem(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                    builder: (context) => InfoPage(penger: penger)),
              );
            },
            logo: penger.logo,
            name: penger.name,
            location: penger.location.location,
          ),
        );
      },
    );
  }

  CircularProgressIndicator _buildLoading() =>
      const CircularProgressIndicator();

  Widget _buildNearbyList(BuildContext context) {
    return BlocBuilder<PengerBloc, PengerState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: SECTION_GAP_HEIGHT),
            Text(
              "Nearby you",
              style: PengoStyle.header(context),
            ),
            if (state is NearestPopularPengersLoading) _buildLoading(),
            if (state is NearestPopularPengersNotLoaded) _buildError(),
            if (state is NearestPopularPengersLoaded)
              _buildNearestPengers(state)
          ],
        );
      },
    );
  }

  ListView _buildNearestPengers(NearestPopularPengersLoaded state) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.nearestPengers.length,
      itemBuilder: (BuildContext ctx, int index) {
        final Penger penger = state.nearestPengers[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: PengerItem(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                    builder: (context) => InfoPage(penger: penger)),
              );
            },
            logo: penger.logo,
            name: penger.name,
            location: penger.location.location,
          ),
        );
      },
    );
  }

  Widget _buildUserBookingList(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: HomeHListView(
        textTheme: textTheme,
        title: "My Booking",
        children: <Widget>[
          SelfBookingItem(),
          SelfBookingItem(),
          SelfBookingItem(),
        ],
      ),
    );
  }

  Widget _buildQuickTapSection(TextTheme textTheme) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <QuickTapItem>[
            QuickTapItem(
              title: "Scan",
              assetName: SCAN_ICON_PATH,
            ),
            QuickTapItem(
              title: "FAQ",
              assetName: INFO_ICON_PATH,
            ),
            QuickTapItem(title: "Coupons", assetName: COUPON_ICON_PATH),
            QuickTapItem(title: "Feedback", assetName: REPORT_ICON_PATH)
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
        )
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
