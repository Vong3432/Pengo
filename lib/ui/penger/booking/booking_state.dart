import 'package:equatable/equatable.dart';

class BookingState extends Equatable {
  const BookingState({this.bookingItemId, this.date, this.time});

  final int? bookingItemId;
  final String? date;
  final String? time;

  @override
  List<Object?> get props => [bookingItemId, date, time];

  BookingState copyWith({int? bookingItemId, String? date, String? time}) {
    return BookingState(
        bookingItemId: bookingItemId ?? this.bookingItemId,
        date: date ?? this.date,
        time: time ?? this.time);
  }
}
