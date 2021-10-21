// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priority_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriorityOption _$PriorityOptionFromJson(Map<String, dynamic> json) {
  return PriorityOption(
    conditions: json['conditions'] as String,
    dpoColumn: DpoColumn.fromJson(json['dpo_col'] as Map<String, dynamic>),
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$PriorityOptionToJson(PriorityOption instance) =>
    <String, dynamic>{
      'conditions': instance.conditions,
      'dpo_col': instance.dpoColumn,
      'value': instance.value,
    };
