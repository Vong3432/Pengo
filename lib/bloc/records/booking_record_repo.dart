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

  Future<List<BookingRecord>> fetchRecords({
    int? limit,
    int? category,
    DateTime? date,
    int? isUsed,
    int? showExpired,
  }) async =>
      _recordsApiProvider.fetchRecords(
        limit: limit,
        category: category,
        date: date,
        isUsed: isUsed,
        showExpired: showExpired,
      );

  Future<BookingRecord> fetchRecord({
    required int recordId,
    bool? showStats,
  }) async =>
      _recordsApiProvider.fetchRecord(
        recordId: recordId,
        showStats: showStats,
      );

  Future<ResponseModel> book(BookingFormState state) async =>
      _recordsApiProvider.book(state);

  Future<void> cancelBook(int recordId) async =>
      _recordsApiProvider.cancelBook(recordId);
}
