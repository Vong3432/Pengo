part of 'booking_record_bloc.dart';

abstract class BookingRecordState extends Equatable {
  const BookingRecordState();

  @override
  List<Object> get props => [];
}

class BookingRecordsInitial extends BookingRecordState {}

class BookingRecordsLoading extends BookingRecordState {}

class BookingRecordsLoaded extends BookingRecordState {
  const BookingRecordsLoaded(this.records);
  final List<BookingRecord> records;
}

class BookingRecordsNotLoaded extends BookingRecordState {}

class BookingRecordInitial extends BookingRecordState {}

class BookingRecordLoading extends BookingRecordState {}

class BookingRecordLoaded extends BookingRecordState {
  const BookingRecordLoaded(this.record);
  final BookingRecord record;
}

class BookingRecordNotLoaded extends BookingRecordState {}
