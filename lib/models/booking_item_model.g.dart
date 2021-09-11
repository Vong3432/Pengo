// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingItem _$BookingItemFromJson(Map<String, dynamic> json) {
  return BookingItem(
    poster: json['poster_url'] as String,
    isActive: json['is_active'] as bool,
    title: json['name'] as String,
    id: json['id'] as int,
    price: (json['price'] as num?)?.toDouble(),
    availableFrom: json['available_from'] as String?,
    availableTo: json['available_to'] as String?,
    startFrom: json['start_from'] == null
        ? null
        : DateTime.parse(json['start_from'] as String),
    endAt: json['end_at'] == null
        ? null
        : DateTime.parse(json['end_at'] as String),
    isPreserveable: json['is_preservable'] as bool?,
    isTransferable: json['is_transferable'] as bool?,
    isCountable: json['is_countable'] as bool?,
    isDiscountable: json['is_discountable'] as bool?,
    maxTransfer: json['maximum_transfer'] as int?,
    maxBook: json['maximum_book'] as int?,
    preservedBook: json['preserved_book'] as int?,
    creditPoints: (json['credit_points'] as num?)?.toDouble(),
    quantity: json['quantity'] as int?,
    discountAmount: (json['discount_amount'] as num?)?.toDouble(),
    categoryId: json['booking_category_id'] as int?,
    description: json['description'] as String?,
    geolocation: json['geolocation'] == null
        ? null
        : Geolocation.fromJson(json['geolocation'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BookingItemToJson(BookingItem instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'is_active': instance.isActive,
    'name': instance.title,
    'poster_url': instance.poster,
    'price': instance.price,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('available_from', instance.availableFrom);
  writeNotNull('available_to', instance.availableTo);
  writeNotNull('start_from', instance.startFrom?.toIso8601String());
  writeNotNull('end_at', instance.endAt?.toIso8601String());
  val['is_preservable'] = instance.isPreserveable;
  val['is_transferable'] = instance.isTransferable;
  val['is_countable'] = instance.isCountable;
  val['is_discountable'] = instance.isDiscountable;
  val['maximum_transfer'] = instance.maxTransfer;
  val['maximum_book'] = instance.maxBook;
  val['preserved_book'] = instance.preservedBook;
  val['credit_points'] = instance.creditPoints;
  val['quantity'] = instance.quantity;
  val['discount_amount'] = instance.discountAmount;
  val['booking_category_id'] = instance.categoryId;
  writeNotNull('description', instance.description);
  writeNotNull('geolocation', instance.geolocation);
  return val;
}
