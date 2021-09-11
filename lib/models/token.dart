import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  Token(this.type, this.token, this.expiresAt);

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  final String type;
  final String token;

  @JsonKey(name: 'expires_at')
  final DateTime expiresAt;
}
