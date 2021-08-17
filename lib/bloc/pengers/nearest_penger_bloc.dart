import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pengo/bloc/pengers/penger_bloc.dart';
import 'package:pengo/bloc/pengers/penger_repo.dart';
import 'package:pengo/models/penger_model.dart';

part 'nearest_penger_event.dart';
part 'nearest_penger_state.dart';

class NearestPengerBloc extends Bloc<NearestPengerEvent, NearestPengerState> {
  NearestPengerBloc() : super(NearestPengerInitial());

  final PengerRepo _pengerRepo = PengerRepo();

  @override
  Stream<NearestPengerState> mapEventToState(
    NearestPengerEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchNearestPengers) {
      yield* _mapFetchNearestPengersToState();
    }
  }

  Stream<NearestPengerState> _mapFetchNearestPengersToState(
      {int? limit, int? pageNum}) async* {
    try {
      yield NearestPengersLoading();
      final List<Penger> pengers =
          await _pengerRepo.fetchNearestPengers(limit: limit, pageNum: pageNum);
      yield NearestPengersLoaded(pengers);
    } catch (_) {
      yield NearestPengersNotLoaded();
    }
  }
}
