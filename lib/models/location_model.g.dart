// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    geolocation:
        Geolocation.fromJson(json['geolocation'] as Map<String, dynamic>),
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'geolocation': instance.geolocation,
      'address': instance.address,
    };
