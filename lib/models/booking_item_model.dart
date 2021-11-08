import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/const/locale_const.dart';
import 'package:pengo/models/booking_category_model.dart';
import 'package:pengo/models/booking_close_date_model.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/models/coupon_model.dart';
import 'package:pengo/models/geolocation_model.dart';
import 'package:pengo/models/priority_option_model.dart';

part 'booking_item_model.g.dart';

@JsonSerializable()
class BookingItem extends Equatable {
  BookingItem({
    required this.poster,
    required this.isActive,
    required this.title,
    required this.id,
    this.price,
    this.availableFrom,
    this.availableTo,
    this.startFrom,
    this.endAt,
    this.isPreserveable,
    this.isTransferable,
    this.isCountable,
    this.isDiscountable,
    this.maxTransfer,
    this.maxBook,
    this.preservedBook,
    this.creditPoints,
    this.quantity,
    this.discountAmount,
    this.categoryId,
    this.description,
    this.geolocation,
    this.bookingRecords,
    this.priorityOption,
    required this.timeGapUnits,
    required this.timeGapValue,
    this.bookingCategory,
    this.isOpen,
    this.coupons,
  });

  factory BookingItem.fromJson(Map<String, dynamic> json) {
    final BookingItem t = _$BookingItemFromJson(json);
    if (t.geolocation != null) {
      t.location = t.geolocation!.name;
    }
    return t;
  }
  Map<String, dynamic> toJson() => _$BookingItemToJson(this);

  final int id;

  @JsonKey(name: 'is_active')
  final bool isActive;

  @JsonKey(name: 'name')
  final String title;

  @JsonKey(name: 'poster_url')
  final String poster;

  final double? price;

  @JsonKey(ignore: true, fromJson: null, toJson: null)
  String? location;

  @JsonKey(name: 'available_from_time', includeIfNull: false)
  final String? availableFrom;

  @JsonKey(name: 'available_to_time', includeIfNull: false)
  final String? availableTo;

  @JsonKey(name: 'start_from', includeIfNull: false)
  final DateTime? startFrom;

  @JsonKey(name: 'end_at', includeIfNull: false)
  final DateTime? endAt;

  @JsonKey(name: 'is_preservable')
  final bool? isPreserveable;

  @JsonKey(name: 'is_transferable')
  final bool? isTransferable;

  @JsonKey(name: 'is_countable')
  final bool? isCountable;

  @JsonKey(name: 'is_discountable')
  final bool? isDiscountable;

  @JsonKey(name: 'maximum_transfer')
  final int? maxTransfer;

  @JsonKey(name: 'maximum_book')
  final int? maxBook;

  @JsonKey(name: 'preserved_book')
  final int? preservedBook;

  @JsonKey(name: 'credit_points')
  final double? creditPoints;

  final int? quantity;

  @JsonKey(name: 'discount_amount')
  final double? discountAmount;

  @JsonKey(name: 'booking_category_id')
  final int? categoryId;

  @JsonKey(includeIfNull: false)
  final String? description;

  @JsonKey(name: 'geolocation', includeIfNull: false)
  final Geolocation? geolocation;

  @JsonKey(name: 'records')
  final List<BookingRecord>? bookingRecords;

  @JsonKey(name: 'time_gap_units')
  final TIME_GAP_UNITS timeGapUnits;

  @JsonKey(name: 'time_gap_value')
  final int timeGapValue;

  @JsonKey(name: 'priority_option')
  final PriorityOption? priorityOption;

  @JsonKey(name: 'category')
  final BookingCategory? bookingCategory;

  @JsonKey(name: 'is_open')
  final bool? isOpen;

  @JsonKey(name: 'coupons')
  final List<Coupon>? coupons;

  @override
  // TODO: implement props
  List<Object?> get props => [
        poster,
        isActive,
        title,
        id,
        price,
        availableFrom,
        availableTo,
        startFrom,
        endAt,
        isPreserveable,
        isTransferable,
        isCountable,
        isDiscountable,
        maxTransfer,
        maxBook,
        preservedBook,
        creditPoints,
        quantity,
        discountAmount,
        categoryId,
        description,
        geolocation,
        bookingRecords,
        priorityOption,
        timeGapUnits,
        timeGapValue,
        bookingCategory,
        isOpen,
        coupons,
      ];
}
