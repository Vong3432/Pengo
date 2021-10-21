// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_validation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingItemValidateMsg _$BookingItemValidateMsgFromJson(
    Map<String, dynamic> json) {
  return BookingItemValidateMsg(
    key: json['key'] as String,
    formattedMsg: json['formattedMsg'] as String,
    pass: json['pass'] as bool,
  );
}

Map<String, dynamic> _$BookingItemValidateMsgToJson(
        BookingItemValidateMsg instance) =>
    <String, dynamic>{
      'pass': instance.pass,
      'key': instance.key,
      'formattedMsg': instance.formattedMsg,
    };

BookingItemValidateStatus _$BookingItemValidateStatusFromJson(
    Map<String, dynamic> json) {
  return BookingItemValidateStatus(
    statusList: (json['msg'] as List<dynamic>)
        .map((e) => BookingItemValidateMsg.fromJson(e as Map<String, dynamic>))
        .toList(),
    bookable: json['bookable'] as bool,
  );
}

Map<String, dynamic> _$BookingItemValidateStatusToJson(
        BookingItemValidateStatus instance) =>
    <String, dynamic>{
      'msg': instance.statusList,
      'bookable': instance.bookable,
    };
