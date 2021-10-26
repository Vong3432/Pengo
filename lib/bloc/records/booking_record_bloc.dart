import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pengo/bloc/records/booking_record_repo.dart';
import 'package:pengo/cubit/booking/booking_form_cubit.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/models/response_model.dart';

part 'booking_record_event.dart';
part 'booking_record_state.dart';

class BookingRecordBloc extends Bloc<BookingRecordEvent, BookingRecordState> {
  BookingRecordBloc() : super(BookingRecordInitial()) {
    on<FetchRecordsEvent>(_fetchRecords);
    on<BookRecordEvent>(_book);
  }
  final RecordRepo _repo = RecordRepo();

  Future<void> _fetchRecords(
    FetchRecordsEvent event,
    Emitter<BookingRecordState> emit,
  ) async {
    try {
      emit(BookingRecordsLoading());
      final List<BookingRecord> records = await _repo.fetchRecords(
        limit: event.limit,
        category: event.category,
        date: event.date,
      );
      emit(BookingRecordsLoaded(records));
    } catch (_) {
      emit(BookingRecordsNotLoaded());
    }
  }

  Future<void> _book(
    BookRecordEvent event,
    Emitter<BookingRecordState> emit,
  ) async {
    try {
      emit(BookingRecordAdding());
      final ResponseModel response = await _repo.book(event.state);
      emit(BookingRecordAdded(response));
    } catch (e) {
      emit(BookingRecordNotAdded(e));
    }
  }
}
