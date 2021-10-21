// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_function_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemFunction _$SystemFunctionFromJson(Map<String, dynamic> json) {
  return SystemFunction(
    name: json['name'] as String,
    description: json['description'] as String,
    isActive: json['is_active'] as bool,
    isPremium: json['is_premium'] as bool,
    price: (json['price'] as num?)?.toDouble(),
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$SystemFunctionToJson(SystemFunction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_premium': instance.isPremium,
      'is_active': instance.isActive,
      'price': instance.price,
      'name': instance.name,
      'description': instance.description,
    };
