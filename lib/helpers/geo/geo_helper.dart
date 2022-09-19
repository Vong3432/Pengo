import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:pengo/bloc/locations/locations_repo.dart';
import 'package:pengo/helpers/geo/geocode_helper.dart';
import 'package:pengo/helpers/storage/shared_preferences_helper.dart';
import 'package:pengo/models/user_model.dart';
import 'package:collection/collection.dart';

class GeoHelper extends ChangeNotifier {
  String? _currentAddress;
  double? _currentLat;
  double? _currentLng;
  bool _isUsingDevice = false;

  factory GeoHelper() {
    return _instance;
  }

  GeoHelper._constructor() {
    _init();
  }
  static final _instance = GeoHelper._constructor();

  void _init() {}

  bool get isUsingDevice => _isUsingDevice;

  set isUsingDevice(bool isUsing) {
    _isUsingDevice = isUsing;
  }

  Map<String, dynamic>? currentPos() {
    if (_currentLat != null && _currentLng != null && _currentAddress != null) {
      return <String, dynamic>{
        "latitude": _currentLat,
        "longitude": _currentLng,
        "address": _currentAddress,
      };
    }
    return null;
  }

  Future<void> setCurrentPos(
    double lat,
    double lng,
    bool isUsingDevice,
  ) async {
    _currentLat = lat;
    _currentLng = lng;
    final LatLon latLng = LatLon(lat, lng);
    final GeocodingResponse? address =
        await getGeoCodingIns().geocoding.getReverse(latLng);
    _currentAddress = address?.results?[0].formattedAddress;
    _isUsingDevice = isUsingDevice;
    notifyListeners();
  }

  Future<Position> getDeviceLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
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
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final Position position = await Geolocator.getCurrentPosition();
    debugPrint("get device $position");
    return position;
  }

  Future<List<UserLocation>?> getUserSavedLocations() async {
    final String? _user = await SharedPreferencesHelper().getKey("user");

    if (_user == null) return null;

    final List<UserLocation> userLocations =
        await LocationRepo().fetchUserLocations();

    return userLocations;
  }

  /// Determine and set the current position of the device or users' favourite position.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<void> determinePosition() async {
    final List<UserLocation> userLocations =
        await getUserSavedLocations() ?? <UserLocation>[];

    // check user saved location > device gps
    if (userLocations.isNotEmpty) {
      final UserLocation? location =
          userLocations.firstWhereOrNull((UserLocation loc) => loc.isFav);

      // Use saved location from users when
      // - Have records
      // - Users are not using device location.
      if (location != null &&
          location.geolocation?.latitude != null &&
          location.geolocation?.longitude != null &&
          _isUsingDevice == false) {
        _currentLat = location.geolocation!.latitude;
        _currentLng = location.geolocation!.longitude;

        final LatLon latLng = LatLon(
          location.geolocation!.latitude,
          location.geolocation!.longitude,
        );
        final GeocodingResponse? address =
            await getGeoCodingIns().geocoding.getReverse(latLng);
        _currentAddress = address?.results?[0].formattedAddress;
        notifyListeners();

        return;
      }
    }

    final Position position = await getDeviceLocation();

    _currentLat = position.latitude;
    _currentLng = position.longitude;
    final LatLon latLng = LatLon(_currentLat!, _currentLng!);
    final GeocodingResponse? address =
        await getGeoCodingIns().geocoding.getReverse(latLng);
    _currentAddress = address?.results?[0].formattedAddress;
    _isUsingDevice = true;

    notifyListeners();
    return;

    // return {
    //   "latitude": position.latitude,
    //   "longitude": position.longitude,
    // };
  }

  Future<double?> distanceBetween(
    double endLat,
    double endLng,
  ) async {
    try {
      return await determinePosition().then((_) {
        final double distance = Geolocator.distanceBetween(
          _currentLat!,
          _currentLng!,
          endLat,
          endLng,
        );
        return distance;
      });
    } catch (e) {
      _currentAddress = null;
      notifyListeners();
      debugPrint("distance bet error: $e");
      return null;
    }
  }
}
