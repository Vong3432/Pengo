import 'package:pengo/bloc/records/booking_record_api_provider.dart';
import 'package:pengo/cubit/booking/booking_form_cubit.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/models/response_model.dart';

class RecordRepo {
  factory RecordRepo() {
    return _instance;
  }

  RecordRepo._constructor();

  static final RecordRepo _instance = RecordRepo._constructor();
  final RecordsApiProvider _recordsApiProvider = RecordsApiProvider();

  Future<List<BookingRecord>> fetchRecords() async =>
      _recordsApiProvider.fetchRecords();
  Future<ResponseModel> book(BookingFormState state) async =>
      _recordsApiProvider.book(state);
}
