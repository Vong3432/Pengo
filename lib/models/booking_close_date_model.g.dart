// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_close_date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingCloseDate _$BookingCloseDateFromJson(Map<String, dynamic> json) {
  return BookingCloseDate(
    name: json['name'] as String,
    id: json['id'] as int?,
    pengerId: json['penger_id'] as int?,
    from: json['from'] as String,
    to: json['to'] as String,
    keyId: json['key_id'] as int?,
    type: _$enumDecode(_$CloseDateTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$BookingCloseDateToJson(BookingCloseDate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'penger_id': instance.pengerId,
      'key_id': instance.keyId,
      'type': _$CloseDateTypeEnumMap[instance.type],
      'from': instance.from,
      'to': instance.to,
      'name': instance.name,
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

const _$CloseDateTypeEnumMap = {
  CloseDateType.ITEM: 'ITEM',
  CloseDateType.ORGANIZATION: 'ORGANIZATION',
  CloseDateType.CATEGORY: 'CATEGORY',
};
