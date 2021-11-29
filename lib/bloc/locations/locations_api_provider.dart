import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/models/response_model.dart';
import 'package:pengo/models/user_model.dart';

class LocationsApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<UserLocation>> fetchRecords({
    int? limit,
    int? category,
    DateTime? date,
  }) async {
    try {
      final response = await _apiHelper.get('/pengoo/locations');
      final List<UserLocation> locations = List<UserLocation>.from(
          (response.data['data']! as List)
              .map((i) => UserLocation.fromJson(i as Map<String, dynamic>)));
      return locations;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<ResponseModel> markAllLocationNotFav() async {
    try {
      final response =
          await _apiHelper.put('/pengoo/locations/0', queryParameters: {
        "mark_all_not_fav": 1,
      });
      final ResponseModel responseModel = ResponseModel.fromResponse(response);
      return responseModel;
    } on DioError catch (e) {
      debugPrint(e.response.toString());
      throw e.response!.data['msg'].toString();
    }
  }

  Future<ResponseModel> saveLocation(
    double lat,
    double lng,
    String name,
  ) async {
    try {
      final response = await _apiHelper.post('/pengoo/locations', data: {
        "latitude": lat,
        "longitude": lng,
        "name": name,
      });
      final ResponseModel responseModel = ResponseModel.fromResponse(response);
      return responseModel;
    } on DioError catch (e) {
      debugPrint(e.response.toString());
      throw e.response!.data['msg'].toString();
    }
  }
}
