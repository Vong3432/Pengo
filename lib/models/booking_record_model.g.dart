// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingRecord _$BookingRecordFromJson(Map<String, dynamic> json) {
  return BookingRecord(
    id: json['id'] as int,
    bookDate: json['book_date'] == null
        ? null
        : BookDate.fromJson(json['book_date'] as Map<String, dynamic>),
    bookTime: json['book_time'] as String?,
    item: json['item'] == null
        ? null
        : BookingItem.fromJson(json['item'] as Map<String, dynamic>),
    goocardID: json['goo_card_id'] as int,
    pengerID: json['penger_id'] as int,
    rewardPoint: (json['reward_point'] as num).toDouble(),
    isUsed: json['is_used'] as bool,
    aheadUserCount: json['ahead_user_count'] as int?,
    streetAddress: json['street_address'] as String?,
    log: json['log'] == null
        ? null
        : GoocardLog.fromJson(json['log'] as Map<String, dynamic>),
    formattedBookDateTime: json['formatted_book_datetime'] == null
        ? null
        : DateTime.parse(json['formatted_book_datetime'] as String),
  );
}

Map<String, dynamic> _$BookingRecordToJson(BookingRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'goo_card_id': instance.goocardID,
      'penger_id': instance.pengerID,
      'book_time': instance.bookTime,
      'book_date': instance.bookDate,
      'item': instance.item,
      'reward_point': instance.rewardPoint,
      'is_used': instance.isUsed,
      'log': instance.log,
      'street_address': instance.streetAddress,
      'ahead_user_count': instance.aheadUserCount,
      'formatted_book_datetime':
          instance.formattedBookDateTime?.toIso8601String(),
    };

BookDate _$BookDateFromJson(Map<String, dynamic> json) {
  return BookDate(
    startDate: json['start_date'] == null
        ? null
        : DateTime.parse(json['start_date'] as String),
    endDate: json['end_date'] == null
        ? null
        : DateTime.parse(json['end_date'] as String),
  );
}

Map<String, dynamic> _$BookDateToJson(BookDate instance) => <String, dynamic>{
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
    };
