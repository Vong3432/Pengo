import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/models/coupon_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:collection/collection.dart';
import 'package:pengo/extensions/date_extension.dart';

part 'booking_form_state.dart';

class BookingFormStateCubit extends Cubit<BookingFormState> {
  BookingFormStateCubit() : super(const BookingFormState());

  void updateFormState({
    String? startDate,
    String? endDate,
    String? bookTime,
    int? bookingItemId,
    int? pengerId,
    String? pin,
    bool? hasPayment,
    bool? hasTime,
    bool? hasStartDate,
    bool? hasEndDate,
    PickerDateRange? range,
    Coupon? coupon,
  }) {
    emit(
      state.copyWith(
        startDate: startDate,
        endDate: endDate,
        bookTime: bookTime,
        bookingItemId: bookingItemId,
        pengerId: pengerId,
        pin: pin,
        hasPayment: hasPayment,
        hasStartDate: hasStartDate,
        hasEndDate: hasEndDate,
        hasTime: hasTime,
        range: range,
        coupon: coupon,
      ),
    );
  }

  bool checkIsOverBooked(
    int maxBook,
    String timeslot,
    List<BookingRecord> records,
  ) {
    if (state.startDate == null || state.endDate == null) {
      return true;
    }

    final DateTime _startDate =
        DateFormat("yyyy-MM-dd").parse(state.startDate!);
    final DateTime _endDate =
        state.endDate != null && state.endDate?.isNotEmpty == true
            ? DateFormat("yyyy-MM-dd").parse(state.endDate!)
            : _startDate;

    // check
    final BookingRecord? matched =
        records.firstWhereOrNull((BookingRecord record) {
      return _startDate.toLocal().isBetweenDate(
                    record.bookDate!.startDate!.toLocal(),
                    record.bookDate!.endDate!.toLocal(),
                  ) ==
              true &&
          _endDate.toLocal().isBetweenDate(
                    record.bookDate!.startDate!.toLocal(),
                    record.bookDate!.endDate!.toLocal(),
                  ) ==
              true &&
          record.bookTime == timeslot;
    });

    if (matched != null) return true;

    return false;
  }
}
