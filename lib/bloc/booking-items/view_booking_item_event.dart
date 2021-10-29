part of 'view_booking_item_bloc.dart';

abstract class ViewBookingItemEvent extends Equatable {
  const ViewBookingItemEvent();

  @override
  List<Object> get props => [];
}

class FetchBookingItemsEvent extends ViewBookingItemEvent {
  const FetchBookingItemsEvent({
    this.catId,
    this.sortDate,
    this.sortDistance,
    this.km,
    this.name,
    this.price,
    this.limit,
    this.searchKeywordOnly,
  });

  final int? limit;
  final int? catId;
  final int? sortDate;
  final int? sortDistance;
  final int? km;
  final String? name;
  final int? price;
  final bool? searchKeywordOnly;
}

class ClearBookingItems extends ViewBookingItemEvent {}

class FetchBookingItemEvent extends ViewBookingItemEvent {
  const FetchBookingItemEvent(this.itemId);
  final int itemId;
}

class FetchBookingItemsByCategoryEvent extends ViewBookingItemEvent {
  const FetchBookingItemsByCategoryEvent(this.catId);
  final int catId;
}
