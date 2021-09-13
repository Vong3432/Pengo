import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pengo/bloc/booking-items/booking_item_repo.dart';
import 'package:pengo/models/booking_item_model.dart';

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
      yield* _mapFetchItemsToState();
    }
    if (event is FetchBookingItemEvent) {
      yield* _mapFetchItem(event.itemId);
    }
    if (event is FetchBookingItemsByCategoryEvent) {
      yield* _mapFetchItemsByCatToState(event.catId);
    }
  }

  Stream<ViewBookingItemState> _mapFetchItemsToState() async* {
    try {
      yield BookingItemsLoading();
      final List<BookingItem> items = await _repo.fetchBookingItems();
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
      Future.delayed(Duration(seconds: 2));
      debugPrint("fet: ${item.toJson()}");
      yield BookingItemLoaded(item);
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
