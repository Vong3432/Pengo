part of 'booking_category_bloc.dart';

abstract class BookingCategoryEvent extends Equatable {
  const BookingCategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchBookingCategoriesEvent extends BookingCategoryEvent {}

class FetchBookingCategoryEvent extends BookingCategoryEvent {}
