import 'package:pengo/bloc/booking-categories/booking_category_api_provider.dart';
import 'package:pengo/models/booking_category_model.dart';

class BookingCategoryRepo {
  factory BookingCategoryRepo() {
    return _instance;
  }

  BookingCategoryRepo._constructor();

  static final BookingCategoryRepo _instance =
      BookingCategoryRepo._constructor();
  final BookingCategoryApiProvider _bookingCategoryApiProvider =
      BookingCategoryApiProvider();

  Future<List<BookingCategory>> fetchBookingCategories() async =>
      _bookingCategoryApiProvider.fetchBookingCategories();
}
