// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingRecord _$BookingRecordFromJson(Map<String, dynamic> json) {
  return BookingRecord(
    id: json['id'] as int,
    bookDate: json['book_date'] as String,
    bookTime: json['book_time'] as String,
    item: BookingItem.fromJson(json['item'] as Map<String, dynamic>),
    goocardID: json['goo_card_id'] as int,
    pengerID: json['penger_id'] as int,
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
    };
