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
  BookingRecordBloc() : super(BookingRecordInitial());

  final RecordRepo _repo = RecordRepo();

  @override
  Stream<BookingRecordState> mapEventToState(
    BookingRecordEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchRecordsEvent) {
      yield* _mapFetchRecordsToState();
    } else if (event is BookRecordEvent) {
      yield* _mapBookRecordToState(event.state);
    }
  }

  Stream<BookingRecordState> _mapFetchRecordsToState() async* {
    try {
      yield BookingRecordsLoading();
      final List<BookingRecord> records = await _repo.fetchRecords();
      yield BookingRecordsLoaded(records);
    } catch (_) {
      yield BookingRecordsNotLoaded();
    }
  }

  Stream<BookingRecordState> _mapBookRecordToState(
    BookingFormState state,
  ) async* {
    try {
      yield BookingRecordAdding();
      final ResponseModel response = await _repo.book(state);
      yield BookingRecordAdded(response);
    } catch (e) {
      yield BookingRecordNotAdded(e);
    }
  }
}
