import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
      ),
    );
  }
}
