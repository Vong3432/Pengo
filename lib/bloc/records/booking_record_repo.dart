import 'package:pengo/bloc/records/booking_record_api_provider.dart';
import 'package:pengo/models/booking_record_model.dart';

class RecordRepo {
  factory RecordRepo() {
    return _instance;
  }

  RecordRepo._constructor();

  static final RecordRepo _instance = RecordRepo._constructor();
  final RecordsApiProvider _recordsApiProvider = RecordsApiProvider();

  Future<List<BookingRecord>> fetchRecords() async =>
      _recordsApiProvider.fetchRecords();
}
