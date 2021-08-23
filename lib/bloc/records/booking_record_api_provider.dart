import 'package:flutter/foundation.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/models/booking_record_model.dart';

class RecordsApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<BookingRecord>> fetchRecords() async {
    try {
      final response = await _apiHelper.get('/pengoo/booking-records');
      final List<BookingRecord> records = List<BookingRecord>.from(
          (response.data['data']! as List)
              .map((i) => BookingRecord.fromJson(i)));
      return records;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
