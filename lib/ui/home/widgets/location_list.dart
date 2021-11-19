import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pengo/bloc/locations/locations_repo.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/geo/geo_helper.dart';
import 'package:pengo/helpers/geo/geocode_helper.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/helpers/toast/toast_helper.dart';
import 'package:pengo/models/providers/auth_model.dart';
import 'package:pengo/models/user_model.dart';
import 'package:pengo/ui/home/widgets/save_location.dart';
import 'package:pengo/ui/home/widgets/user_location_list.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class LocationList extends StatefulWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      GeoHelper().determinePosition();
    } catch (e) {
      showToast(msg: e.toString());
    }

    _loadUserLocations(
      Provider.of<AuthModel>(context, listen: false).user?.user,
    );
  }

  List<UserLocation> _userLocations = [];

  @override
  Widget build(BuildContext context) {
    final User? user =
        context.select<AuthModel, User?>((AuthModel value) => value.user?.user);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            title: Container(),
          ),
          CustomSliverBody(
            content: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "My location",
                      style: PengoStyle.navigationTitle(context).copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                      ),
                    ),
                    _buildDeviceAddressRow(user),
                    const SizedBox(
                      height: SECTION_GAP_HEIGHT * 1.5,
                    ),
                    if (context.watch<AuthModel>().user != null)
                      UsersOwnLocationList(
                        locations: _userLocations,
                        showSaveModal: (double lat, double lng, String name) =>
                            _showSaveModal(lat, lng, user, name: name),
                      ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDeviceAddressRow(User? user) {
    final bool usingDevice =
        context.select<GeoHelper, bool>((gh) => gh.isUsingDevice);
    // if (usingDevice == false) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: SECTION_GAP_HEIGHT * 1.5,
        ),
        Text(
          "Device location",
          style: PengoStyle.title2(context).copyWith(
            color: secondaryTextColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FutureBuilder<Position>(
          future: GeoHelper().getDeviceLocation(),
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final LatLon latLng = LatLon(
                  snapshot.data!.latitude,
                  snapshot.data!.longitude,
                );

                final bool check = snapshot.data?.longitude ==
                        context.watch<GeoHelper>().currentPos()?['longitude'] &&
                    snapshot.data?.latitude ==
                        context.watch<GeoHelper>().currentPos()?['latitude'] &&
                    usingDevice;

                return ListTile(
                  onTap: () async {
                    context.read<GeoHelper>().setCurrentPos(
                          snapshot.data!.latitude,
                          snapshot.data!.longitude,
                          true,
                        );
                    if (user == null) return;

                    await LocationRepo().markAllLocationNotFav();

                    showCupertinoModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: mediaQuery(context).size.height * 0.25,
                            padding: const EdgeInsets.all(18),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Save this location?",
                                    style: PengoStyle.title(context),
                                  ),
                                  Text(
                                    "You can use saved location without location access in the future",
                                    style: PengoStyle.body(context).copyWith(
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: SECTION_GAP_HEIGHT,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomButton(
                                          fullWidth: false,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            _showSaveModal(
                                              snapshot.data!.latitude,
                                              snapshot.data!.longitude,
                                              user,
                                            );
                                          },
                                          text: const Text("Save"),
                                        ),
                                      ),
                                      Expanded(
                                        child: CupertinoButton(
                                          child: const Text("No"),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 22,
                  leading: SvgPicture.asset(
                    LOCATION_ICON_PATH,
                    color: secondaryTextColor,
                    width: 22,
                  ),
                  title: FutureBuilder<GeocodingResponse?>(
                    future: getGeoCodingIns().geocoding.getReverse(latLng),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<GeocodingResponse?> snapshot,
                    ) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data?.results?[0].formattedAddress ?? "",
                          style: PengoStyle.smallerText(context).copyWith(
                            height: 1.2,
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  trailing: check
                      ? Icon(
                          Icons.check,
                          color: primaryColor,
                        )
                      : const SizedBox(),
                );
              }
              return ListTile(
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 22,
                leading: Icon(
                  Icons.warning_amber,
                  size: 22,
                  color: Colors.amber[900],
                ),
                title: Text(
                  "Enable gps",
                  style: PengoStyle.title2(context).copyWith(
                    color: Colors.amber[900],
                    height: 1.6,
                  ),
                ),
                subtitle: Text(
                  "Enable your location permission in phone setting to continue",
                  style: PengoStyle.smallerText(context).copyWith(
                    color: grayTextColor,
                    height: 1.2,
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const SkeletonText(height: 18);
            }
            return Container();
          },
        )
      ],
    );
  }

  void _showSaveModal(
    double latitude,
    double longitude,
    User? user, {
    String? name,
  }) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: mediaQuery(context).viewInsets.bottom,
          ),
          child: SaveLocationModal(
            lat: latitude,
            lng: longitude,
            defaultName: name,
          ),
        );
      },
    ).then((_) {
      debugPrint("modal close");
      _loadUserLocations(user);
    });
  }

  /// Fetch and set locations into AuthModel provider
  Future<List<UserLocation>?> _loadUserLocations(User? user) async {
    debugPrint("user $user");
    if (user == null) return const <UserLocation>[];

    // call load users' position api
    final List<UserLocation> locations =
        await LocationRepo().fetchUserLocations();

    setState(() {
      _userLocations = locations;
    });

    return locations;
  }
}
