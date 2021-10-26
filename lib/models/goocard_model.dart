import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/models/goocard_log_model.dart';

part 'goocard_model.g.dart';

@JsonSerializable()
class Goocard {
  const Goocard({
    required this.userId,
    required this.id,
    required this.creditPoints,
    this.logs,
    this.records,
  });

  factory Goocard.fromJson(Map<String, dynamic> json) =>
      _$GoocardFromJson(json);
  Map<String, dynamic> toJson() => _$GoocardToJson(this);

  final int id;

  @JsonKey(name: 'user_id')
  final int userId;

  final List<GoocardLog>? logs;
  final List<BookingRecord>? records;

  @JsonKey(name: 'credit_points')
  final double creditPoints;
}
