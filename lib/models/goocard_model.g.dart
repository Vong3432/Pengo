// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goocard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goocard _$GoocardFromJson(Map<String, dynamic> json) {
  return Goocard(
    userId: json['user_id'] as int,
    id: json['id'] as int,
    creditPoints: (json['credit_points'] as num).toDouble(),
    logs: (json['logs'] as List<dynamic>?)
        ?.map((e) => GoocardLog.fromJson(e as Map<String, dynamic>))
        .toList(),
    records: (json['records'] as List<dynamic>?)
        ?.map((e) => BookingRecord.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GoocardToJson(Goocard instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'logs': instance.logs,
      'records': instance.records,
      'credit_points': instance.creditPoints,
    };
