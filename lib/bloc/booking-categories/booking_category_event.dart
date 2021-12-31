part of 'booking_category_bloc.dart';

abstract class BookingCategoryEvent extends Equatable {
  const BookingCategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchBookingCategoriesEvent extends BookingCategoryEvent {
  const FetchBookingCategoriesEvent({this.pengerId});

  final int? pengerId;
}

class FetchBookingCategoryEvent extends BookingCategoryEvent {}
