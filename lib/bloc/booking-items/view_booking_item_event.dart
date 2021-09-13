part of 'view_booking_item_bloc.dart';

abstract class ViewBookingItemEvent extends Equatable {
  const ViewBookingItemEvent();

  @override
  List<Object> get props => [];
}

class FetchBookingItemsEvent extends ViewBookingItemEvent {}

class FetchBookingItemEvent extends ViewBookingItemEvent {
  const FetchBookingItemEvent(this.itemId);
  final int itemId;
}

class FetchBookingItemsByCategoryEvent extends ViewBookingItemEvent {
  const FetchBookingItemsByCategoryEvent(this.catId);
  final int catId;
}
