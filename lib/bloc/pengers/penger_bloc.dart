import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pengo/bloc/pengers/penger_repo.dart';
import 'package:pengo/models/penger_model.dart';

part 'penger_event.dart';
part 'penger_state.dart';

class PengerBloc extends Bloc<PengerEvent, PengerState> {
  PengerBloc() : super(PengerInitial());

  final PengerRepo _pengerRepo = PengerRepo();

  @override
  Stream<PengerState> mapEventToState(
    PengerEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchPengers) {
      yield* _mapFetchPengersToState(
        sortDate: event.sortDate,
        km: event.km,
        name: event.name,
        sortDistance: event.sortDistance,
        limit: event.limit,
        searchKeywordOnly: event.searchKeywordOnly,
      );
    }
    if (event is FetchPopularNearestPengers) {
      yield* _mapFetchPopularNearestPengersToState();
    }
  }

  Stream<PengerState> _mapFetchPengersToState({
    int? sortDate,
    int? sortDistance,
    int? km,
    int? limit,
    String? name,
    bool? searchKeywordOnly,
  }) async* {
    try {
      yield PengersLoading();
      final List<Penger> pengers = await _pengerRepo.fetchPengers(
        sortDate: sortDate,
        sortDistance: sortDistance,
        km: km,
        name: name,
        limit: limit,
        searchKeywordOnly: searchKeywordOnly,
      );
      await Future.delayed(const Duration(seconds: 1));
      yield PengersLoaded(pengers);
    } catch (_) {
      yield PengersNotLoaded();
    }
  }

  Stream<PengerState> _mapFetchPopularNearestPengersToState(
      {int? limit, int? pageNum}) async* {
    try {
      yield NearestPopularPengersLoading();
      final List<Penger> nearestPengers =
          await _pengerRepo.fetchNearestPengers(limit: limit, pageNum: pageNum);
      final List<Penger> popularPengers =
          await _pengerRepo.fetchPopularPengers(limit: limit, pageNum: pageNum);

      await Future.delayed(const Duration(seconds: 1));
      yield NearestPopularPengersLoaded(nearestPengers, popularPengers);
    } catch (_) {
      yield NearestPopularPengersNotLoaded();
    }
  }
}
