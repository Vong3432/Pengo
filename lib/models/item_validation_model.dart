import 'package:json_annotation/json_annotation.dart';

part 'item_validation_model.g.dart';

@JsonSerializable()
class BookingItemValidateMsg {
  const BookingItemValidateMsg({
    required this.key,
    required this.formattedMsg,
    required this.pass,
  });

  factory BookingItemValidateMsg.fromJson(Map<String, dynamic> json) =>
      _$BookingItemValidateMsgFromJson(json);
  Map<String, dynamic> toJson() => _$BookingItemValidateMsgToJson(this);

  final bool pass;
  final String key;
  final String formattedMsg;
}

@JsonSerializable()
class BookingItemValidateStatus {
  BookingItemValidateStatus({
    required this.statusList,
    required this.bookable,
  });

  factory BookingItemValidateStatus.fromJson(Map<String, dynamic> json) =>
      _$BookingItemValidateStatusFromJson(json);
  Map<String, dynamic> toJson() => _$BookingItemValidateStatusToJson(this);

  @JsonKey(name: 'msg')
  final List<BookingItemValidateMsg> statusList;
  final bool bookable;
}
