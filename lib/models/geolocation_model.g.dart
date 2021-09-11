// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geolocation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geolocation _$GeolocationFromJson(Map<String, dynamic> json) {
  return Geolocation(
    (json['latitude'] as num).toDouble(),
    (json['longitude'] as num).toDouble(),
    json['name'] as String?,
  );
}

Map<String, dynamic> _$GeolocationToJson(Geolocation instance) {
  final val = <String, dynamic>{
    'latitude': instance.latitude,
    'longitude': instance.longitude,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  return val;
}
