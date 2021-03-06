// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingCategory _$BookingCategoryFromJson(Map<String, dynamic> json) {
  return BookingCategory(
    isEnabled: json['is_enable'] as bool,
    name: json['name'] as String,
    id: json['id'] as int,
    bookingItems: (json['bookingItems'] as List<dynamic>?)
        ?.map((e) => BookingItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    bookingOptions: (json['booking_options'] as List<dynamic>?)
        ?.map((e) => SystemFunction.fromJson(e as Map<String, dynamic>))
        .toList(),
    penger: json['created_by'] == null
        ? null
        : Penger.fromJson(json['created_by'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BookingCategoryToJson(BookingCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_enable': instance.isEnabled,
      'name': instance.name,
      'bookingItems': instance.bookingItems,
      'booking_options': instance.bookingOptions,
      'created_by': instance.penger,
    };
