// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goocard_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoocardLog _$GoocardLogFromJson(Map<String, dynamic> json) {
  return GoocardLog(
    id: json['id'] as int,
    title: json['title'] as String,
    gooCardId: json['goo_card_id'] as int,
    body: json['body'] as String?,
    type: _$enumDecode(_$GoocardLogTypeEnumMap, json['type']),
    createdAt: DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$GoocardLogToJson(GoocardLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'goo_card_id': instance.gooCardId,
      'title': instance.title,
      'body': instance.body,
      'type': _$GoocardLogTypeEnumMap[instance.type],
      'created_at': instance.createdAt.toIso8601String(),
    };

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

const _$GoocardLogTypeEnumMap = {
  GoocardLogType.pass: 'pass',
  GoocardLogType.coupon: 'coupon',
};
