import 'package:pengo/bloc/booking-items/booking_item_api_provider.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/response_model.dart';

class BookingItemRepo {
  factory BookingItemRepo() {
    return _instance;
  }

  BookingItemRepo._constructor();

  static final BookingItemRepo _instance = BookingItemRepo._constructor();
  final BookingItemApiProvider _bookingItemApiProvider =
      BookingItemApiProvider();

  Future<List<BookingItem>> fetchBookingItems({int? catId}) async =>
      _bookingItemApiProvider.fetchBookingItems(catId: catId);

  Future<BookingItem> fetchBookingItem({required int id}) async =>
      _bookingItemApiProvider.fetchBookingItem(id: id);
}
