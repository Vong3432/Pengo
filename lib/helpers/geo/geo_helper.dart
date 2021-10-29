import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pengo/helpers/geo/geocode_helper.dart';
import 'package:pengo/models/auth_model.dart';
import 'package:pengo/models/user_model.dart';
import 'package:collection/collection.dart';

class GeoHelper extends ChangeNotifier {
  String? _currentAddress;
  double? _currentLat;
  double? _currentLng;

  factory GeoHelper() {
    return _instance;
  }

  GeoHelper._constructor() {
    _init();
  }
  static final _instance = GeoHelper._constructor();

  void _init() {}

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

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<void> determinePosition({Auth? auth}) async {
    bool serviceEnabled;
    LocationPermission permission;

    // check user saved location > device gps
    if (auth != null && auth.user.locations != null) {
      final UserLocation? location = auth.user.locations!
          .firstWhereOrNull((UserLocation loc) => loc.isFav);

      if (location != null &&
          location.geolocation?.latitude != null &&
          location.geolocation?.longitude != null) {
        _currentLng = location.geolocation!.latitude;
        _currentLng = location.geolocation!.longitude;
        LatLon latLng = LatLon(_currentLat!, _currentLng!);
        final GeocodingResponse? address =
            await getGeoCodingIns().geocoding.getReverse(latLng);
        _currentAddress = address?.results?[0].formattedAddress;
        notifyListeners();

        return;
      }
    }

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
    Position position = await Geolocator.getCurrentPosition();
    debugPrint("Position: ${position.toString()}");

    _currentLat = position.latitude;
    _currentLng = position.longitude;
    final LatLon latLng = LatLon(_currentLat!, _currentLng!);
    final GeocodingResponse? address =
        await getGeoCodingIns().geocoding.getReverse(latLng);
    _currentAddress = address?.results?[0].formattedAddress;

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
    if (_currentLng == null || _currentLng == null) await determinePosition();
    try {
      final double distance = Geolocator.distanceBetween(
          _currentLat!, _currentLng!, endLat, endLng);
      return distance;
    } catch (e) {
      debugPrint("distance bet error: $e");
      return null;
    }
  }
}
