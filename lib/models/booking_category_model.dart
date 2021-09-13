import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/booking_item_model.dart';

part 'booking_category_model.g.dart';

@JsonSerializable()
class BookingCategory {
  const BookingCategory({
    required this.isEnabled,
    required this.name,
    required this.id,
    this.bookingItems,
  });

  factory BookingCategory.fromJson(Map<String, dynamic> json) =>
      _$BookingCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$BookingCategoryToJson(this);

  final int id;

  @JsonKey(name: 'is_enable')
  final bool isEnabled;

  final String name;
  final List<BookingItem>? bookingItems;
}
