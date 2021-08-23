import 'package:flutter/foundation.dart';
import 'package:pengo/models/booking_record_model.dart';

class BookingPassModel extends ChangeNotifier {
  BookingRecord? _record;

  BookingRecord? getRecord() {
    return _record;
  }

  set record(BookingRecord record) {
    _record = record;
    notifyListeners();
  }

  void clearRecord() {
    _record = null;
    notifyListeners();
  }
}
