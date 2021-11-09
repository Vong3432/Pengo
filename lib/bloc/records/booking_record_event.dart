part of 'booking_record_bloc.dart';

abstract class BookingRecordEvent extends Equatable {
  const BookingRecordEvent();

  @override
  List<Object> get props => [];
}

class FetchRecordsEvent extends BookingRecordEvent {
  const FetchRecordsEvent({
    this.limit,
    this.category,
    this.date,
    this.isUsed,
  });

  final int? limit;
  final int? category;
  final int? isUsed;
  final DateTime? date;
}

class BookRecordEvent extends BookingRecordEvent {
  const BookRecordEvent(this.state);

  final BookingFormState state;
}
