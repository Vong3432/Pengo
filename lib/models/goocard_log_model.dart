import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/user_model.dart';

part 'goocard_log_model.g.dart';

enum GoocardLogType {
  @JsonValue("pass")
  pass,
  @JsonValue("coupon")
  coupon,
}

@JsonSerializable()
class GoocardLog {
  const GoocardLog({
    required this.id,
    required this.title,
    required this.gooCardId,
    this.body,
    required this.type,
    required this.createdAt,
  });

  factory GoocardLog.fromJson(Map<String, dynamic> json) =>
      _$GoocardLogFromJson(json);
  Map<String, dynamic> toJson() => _$GoocardLogToJson(this);

  final int id;
  @JsonKey(name: 'goo_card_id')
  final int gooCardId;
  final String title;
  final String? body;
  final GoocardLogType type;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
}
