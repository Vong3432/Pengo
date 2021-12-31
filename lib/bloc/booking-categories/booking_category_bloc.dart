import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pengo/bloc/booking-categories/booking_category_repo.dart';
import 'package:pengo/models/booking_category_model.dart';

part 'booking_category_event.dart';
part 'booking_category_state.dart';

class BookingCategoryBloc
    extends Bloc<BookingCategoryEvent, BookingCategoryState> {
  BookingCategoryBloc() : super(BookingCategoryInitial());

  final BookingCategoryRepo _repo = BookingCategoryRepo();

  @override
  Stream<BookingCategoryState> mapEventToState(
    BookingCategoryEvent event,
  ) async* {
    debugPrint(event.toString());
    // TODO: implement mapEventToState
    if (event is FetchBookingCategoriesEvent) {
      yield* _mapFetchCategoriesToState(pengerId: event.pengerId);
    }
  }

  Stream<BookingCategoryState> _mapFetchCategoriesToState({
    int? pengerId,
  }) async* {
    try {
      yield BookingCategoriesLoading();
      final List<BookingCategory> categories =
          await _repo.fetchBookingCategories(pengerId: pengerId);
      yield BookingCategoriesLoaded(categories);
    } catch (_) {
      yield BookingCategoriesNotLoaded();
    }
  }
}
