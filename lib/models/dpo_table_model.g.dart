// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dpo_table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DpoTable _$DpoTableFromJson(Map<String, dynamic> json) {
  return DpoTable(
    id: json['id'] as int?,
    tableName: json['table_name'] as String,
    isActive: json['is_active'] as bool,
    dpoColumns: (json['dpo_cols'] as List<dynamic>?)
        ?.map((e) => DpoColumn.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DpoTableToJson(DpoTable instance) => <String, dynamic>{
      'id': instance.id,
      'table_name': instance.tableName,
      'is_active': instance.isActive,
      'dpo_cols': instance.dpoColumns,
    };
