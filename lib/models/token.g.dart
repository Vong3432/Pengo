// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    json['type'] as String,
    json['token'] as String,
    DateTime.parse(json['expires_at'] as String),
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'type': instance.type,
      'token': instance.token,
      'expires_at': instance.expiresAt.toIso8601String(),
    };
