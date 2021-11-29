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
    isVirtual: json['is_virtual'] as bool?,
    price: (json['price'] as num?)?.toDouble(),
    availableFrom: json['available_from_time'] as String?,
    availableTo: json['available_to_time'] as String?,
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
    bookingRecords: (json['records'] as List<dynamic>?)
        ?.map((e) => BookingRecord.fromJson(e as Map<String, dynamic>))
        .toList(),
    priorityOption: json['priority_option'] == null
        ? null
        : PriorityOption.fromJson(
            json['priority_option'] as Map<String, dynamic>),
    timeGapUnits: _$enumDecode(_$TIME_GAP_UNITSEnumMap, json['time_gap_units']),
    timeGapValue: json['time_gap_value'] as int,
    bookingCategory: json['category'] == null
        ? null
        : BookingCategory.fromJson(json['category'] as Map<String, dynamic>),
    isOpen: json['is_open'] as bool?,
    coupons: (json['coupons'] as List<dynamic>?)
        ?.map((e) => Coupon.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BookingItemToJson(BookingItem instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'is_active': instance.isActive,
    'name': instance.title,
    'poster_url': instance.poster,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('price', instance.price);
  writeNotNull('available_from_time', instance.availableFrom);
  writeNotNull('available_to_time', instance.availableTo);
  writeNotNull('start_from', instance.startFrom?.toIso8601String());
  writeNotNull('end_at', instance.endAt?.toIso8601String());
  val['is_preservable'] = instance.isPreserveable;
  val['is_virtual'] = instance.isVirtual;
  val['is_transferable'] = instance.isTransferable;
  val['is_countable'] = instance.isCountable;
  val['is_discountable'] = instance.isDiscountable;
  val['maximum_transfer'] = instance.maxTransfer;
  val['maximum_book'] = instance.maxBook;
  val['preserved_book'] = instance.preservedBook;
  val['credit_points'] = instance.creditPoints;
  writeNotNull('quantity', instance.quantity);
  val['discount_amount'] = instance.discountAmount;
  val['booking_category_id'] = instance.categoryId;
  writeNotNull('description', instance.description);
  writeNotNull('geolocation', instance.geolocation);
  val['records'] = instance.bookingRecords;
  val['time_gap_units'] = _$TIME_GAP_UNITSEnumMap[instance.timeGapUnits];
  val['time_gap_value'] = instance.timeGapValue;
  val['priority_option'] = instance.priorityOption;
  val['category'] = instance.bookingCategory;
  val['is_open'] = instance.isOpen;
  val['coupons'] = instance.coupons;
  return val;
}

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$TIME_GAP_UNITSEnumMap = {
  TIME_GAP_UNITS.hours: 'hours',
  TIME_GAP_UNITS.seconds: 'seconds',
  TIME_GAP_UNITS.minutes: 'minutes',
};
