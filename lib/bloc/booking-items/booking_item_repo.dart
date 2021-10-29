import 'package:pengo/bloc/booking-items/booking_item_api_provider.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/item_validation_model.dart';
import 'package:pengo/models/response_model.dart';

class BookingItemRepo {
  factory BookingItemRepo() {
    return _instance;
  }

  BookingItemRepo._constructor();

  static final BookingItemRepo _instance = BookingItemRepo._constructor();
  final BookingItemApiProvider _bookingItemApiProvider =
      BookingItemApiProvider();

  Future<List<BookingItem>> fetchBookingItems({
    int? catId,
    int? sortDate,
    int? sortDistance,
    int? km,
    String? name,
    int? price,
    int? limit,
    bool? searchKeywordOnly,
  }) async =>
      _bookingItemApiProvider.fetchBookingItems(
        catId: catId,
        sortDate: sortDate,
        sortDistance: sortDistance,
        km: km,
        name: name,
        price: price,
        limit: limit,
        searchKeywordOnly: searchKeywordOnly,
      );

  Future<BookingItem> fetchBookingItem({required int id}) async =>
      _bookingItemApiProvider.fetchBookingItem(id: id);

  Future<BookingItemValidateStatus> getItemStatusMsg({
    required int id,
  }) async =>
      _bookingItemApiProvider.validateItemStatus(id: id);
}
