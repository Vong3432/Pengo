part of 'view_booking_item_bloc.dart';

abstract class ViewBookingItemState extends Equatable {
  const ViewBookingItemState();
  @override
  List<Object> get props => [];
}

class BookingItemInitial extends ViewBookingItemState {}

class BookingItemLoading extends ViewBookingItemState {}

class BookingItemLoaded extends ViewBookingItemState {
  const BookingItemLoaded(this.item);
  final BookingItem item;
}

class BookingItemNotLoaded extends ViewBookingItemState {}

class BookingItemsInitial extends ViewBookingItemState {}

class BookingItemsLoading extends ViewBookingItemState {}

class BookingItemsLoaded extends ViewBookingItemState {
  const BookingItemsLoaded(this.items);

  final List<BookingItem> items;
}

class BookingItemsNotLoaded extends ViewBookingItemState {}
