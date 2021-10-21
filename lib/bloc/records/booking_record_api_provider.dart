import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pengo/cubit/booking/booking_form_cubit.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/models/response_model.dart';

class RecordsApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<BookingRecord>> fetchRecords() async {
    try {
      final response = await _apiHelper.get('/pengoo/booking-records');
      final List<BookingRecord> records = List<BookingRecord>.from(
          (response.data['data']! as List)
              .map((i) => BookingRecord.fromJson(i as Map<String, dynamic>)));
      return records;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<ResponseModel> book(BookingFormState data) async {
    try {
      final response =
          await _apiHelper.post('/pengoo/booking-records', data: data.toJson());
      final ResponseModel responseModel = ResponseModel.fromResponse(response);
      return responseModel;
    } on DioError catch (e) {
      debugPrint(e.response.toString());
      throw e.response!.data['msg'].toString();
    }
  }
}
