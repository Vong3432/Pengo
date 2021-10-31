import 'package:pengo/bloc/locations/locations_api_provider.dart';
import 'package:pengo/bloc/records/booking_record_api_provider.dart';
import 'package:pengo/cubit/booking/booking_form_cubit.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/models/response_model.dart';
import 'package:pengo/models/user_model.dart';

class LocationRepo {
  factory LocationRepo() {
    return _instance;
  }

  LocationRepo._constructor();

  static final LocationRepo _instance = LocationRepo._constructor();
  final LocationsApiProvider _locationsApiProvider = LocationsApiProvider();

  Future<List<UserLocation>> fetchUserLocations() async =>
      _locationsApiProvider.fetchRecords();

  Future<ResponseModel> markAllLocationNotFav() async =>
      _locationsApiProvider.markAllLocationNotFav();
  Future<ResponseModel> saveLocation(
    double lat,
    double lng,
    String name,
  ) async =>
      _locationsApiProvider.saveLocation(
        lat,
        lng,
        name,
      );
}
