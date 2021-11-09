import 'package:flutter/foundation.dart';
import 'package:pengo/models/booking_record_model.dart';

class BookingPassModel extends ChangeNotifier {
  BookingRecord? _record;
  String? _pin;

  BookingRecord? getRecord() {
    return _record;
  }

  String? getPin() => _pin;

  set record(BookingRecord record) {
    _record = record;
    notifyListeners();
  }

  set pin(String pin) {
    _pin = pin;
    notifyListeners();
  }

  void clearRecord() {
    _record = null;
    _pin = null;
    notifyListeners();
  }
}
