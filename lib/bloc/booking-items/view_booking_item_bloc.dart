import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pengo/bloc/booking-items/booking_item_repo.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/item_validation_model.dart';

part 'view_booking_item_event.dart';
part 'view_booking_item_state.dart';

class ViewItemBloc extends Bloc<ViewBookingItemEvent, ViewBookingItemState> {
  ViewItemBloc() : super(BookingItemInitial());

  final BookingItemRepo _repo = BookingItemRepo();

  @override
  Stream<ViewBookingItemState> mapEventToState(
    ViewBookingItemEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchBookingItemsEvent) {
      yield* _mapFetchItemsToState(
        catId: event.catId,
        sortDate: event.sortDate,
        sortDistance: event.sortDistance,
        km: event.km,
        name: event.name,
        price: event.price,
        limit: event.limit,
        searchKeywordOnly: event.searchKeywordOnly,
      );
    }
    if (event is FetchBookingItemEvent) {
      yield* _mapFetchItem(event.itemId);
    }
    if (event is FetchBookingItemsByCategoryEvent) {
      yield* _mapFetchItemsByCatToState(event.catId);
    }
  }

  Stream<ViewBookingItemState> _mapClearItemsToState() async* {
    yield BookingItemsInitial();
    yield const BookingItemsLoaded(<BookingItem>[]);
  }

  Stream<ViewBookingItemState> _mapFetchItemsToState({
    int? catId,
    int? sortDate,
    int? sortDistance,
    int? km,
    String? name,
    int? price,
    int? limit,
    bool? searchKeywordOnly,
  }) async* {
    try {
      yield BookingItemsLoading();
      final List<BookingItem> items = await _repo.fetchBookingItems(
        catId: catId,
        sortDistance: sortDistance,
        sortDate: sortDate,
        km: km,
        name: name,
        price: price,
        limit: limit,
        searchKeywordOnly: searchKeywordOnly,
      );
      await Future.delayed(const Duration(seconds: 1));
      yield BookingItemsLoaded(items);
    } catch (_) {
      yield BookingItemsNotLoaded();
    }
  }

  Stream<ViewBookingItemState> _mapFetchItemsByCatToState(int catId) async* {
    try {
      yield BookingItemsLoading();
      final List<BookingItem> items =
          await _repo.fetchBookingItems(catId: catId);
      yield BookingItemsLoaded(items);
    } catch (_) {
      yield BookingItemsNotLoaded();
    }
  }

  Stream<ViewBookingItemState> _mapFetchItem(int itemId) async* {
    try {
      yield BookingItemLoading();
      final BookingItem item = await _repo.fetchBookingItem(id: itemId);
      final BookingItemValidateStatus status =
          await _repo.getItemStatusMsg(id: itemId);
      yield BookingItemLoaded(item, status);
    } catch (_) {
      yield BookingItemNotLoaded();
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
