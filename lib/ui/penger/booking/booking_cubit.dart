import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pengo/ui/penger/booking/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingState());

  void setDate(String date) {
    emit(state.copyWith(date: date));
  }

  void setTime(String time) {
    emit(state.copyWith(time: time));
  }

  void setBookingItemId(int id) {
    emit(state.copyWith(bookingItemId: id));
  }
}
