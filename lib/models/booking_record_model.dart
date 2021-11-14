import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/goocard_log_model.dart';
import 'package:pengo/models/goocard_model.dart';

part 'booking_record_model.g.dart';

@JsonSerializable()
class BookingRecord {
  const BookingRecord({
    required this.id,
    required this.bookDate,
    this.bookTime,
    required this.item,
    required this.goocardID,
    required this.pengerID,
    required this.rewardPoint,
    required this.isUsed,
    this.aheadUserCount,
    this.streetAddress,
    this.log,
    this.formattedBookDateTime,
    this.isReviewed,
    this.goocard,
  });

  factory BookingRecord.fromJson(Map<String, dynamic> json) =>
      _$BookingRecordFromJson(json);
  Map<String, dynamic> toJson() => _$BookingRecordToJson(this);

  final int id;

  @JsonKey(name: 'goo_card_id')
  final int goocardID;

  @JsonKey(name: 'penger_id')
  final int pengerID;

  @JsonKey(name: 'book_time')
  final String? bookTime;

  @JsonKey(name: 'book_date')
  final BookDate? bookDate;

  @JsonKey(name: 'item')
  final BookingItem? item;

  @JsonKey(name: 'reward_point')
  final double rewardPoint;

  final Goocard? goocard;

  @JsonKey(name: 'is_used')
  final bool isUsed;

  @JsonKey(name: 'log')
  final GoocardLog? log;

  @JsonKey(name: 'street_address')
  final String? streetAddress;

  @JsonKey(name: 'ahead_user_count')
  final int? aheadUserCount;

  @JsonKey(name: 'formatted_book_datetime')
  final DateTime? formattedBookDateTime;

  @JsonKey(name: 'is_reviewed')
  final bool? isReviewed;
}

@JsonSerializable()
class BookDate {
  const BookDate({
    required this.startDate,
    required this.endDate,
  });

  factory BookDate.fromJson(Map<String, dynamic> json) =>
      _$BookDateFromJson(json);
  Map<String, dynamic> toJson() => _$BookDateToJson(this);

  @JsonKey(name: "start_date")
  final DateTime? startDate;
  @JsonKey(name: "end_date")
  final DateTime? endDate;
}
