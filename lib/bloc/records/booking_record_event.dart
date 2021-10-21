part of 'booking_record_bloc.dart';

abstract class BookingRecordEvent extends Equatable {
  const BookingRecordEvent();

  @override
  List<Object> get props => [];
}

class FetchRecordsEvent extends BookingRecordEvent {}

class BookRecordEvent extends BookingRecordEvent {
  const BookRecordEvent(this.state);

  final BookingFormState state;
}
