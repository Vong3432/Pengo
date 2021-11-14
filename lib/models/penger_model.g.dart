// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Penger _$PengerFromJson(Map<String, dynamic> json) {
  return Penger(
    id: json['id'] as int,
    name: json['name'] as String,
    logo: json['logo'] as String,
    items: (json['booking_items'] as List<dynamic>?)
        ?.map((e) => BookingItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    description: json['description'] as String?,
    location: json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
    reviews: (json['reviews'] as List<dynamic>?)
        ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
        .toList(),
    closeDates: (json['close_dates'] as List<dynamic>?)
        ?.map((e) => BookingCloseDate.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PengerToJson(Penger instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'description': instance.description,
      'location': instance.location,
      'reviews': instance.reviews,
      'booking_items': instance.items,
      'close_dates': instance.closeDates,
    };
