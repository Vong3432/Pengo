// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dpo_column_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DpoColumn _$DpoColumnFromJson(Map<String, dynamic> json) {
  return DpoColumn(
    id: json['id'] as int?,
    tableId: json['dpo_table_id'] as int,
    column: json['column'] as String,
    isActive: json['is_active'] as bool,
    relatedTable: json['related_table'] == null
        ? null
        : DpoTable.fromJson(json['related_table'] as Map<String, dynamic>),
    dpoTable: json['dpo_table'] == null
        ? null
        : DpoTable.fromJson(json['dpo_table'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DpoColumnToJson(DpoColumn instance) => <String, dynamic>{
      'id': instance.id,
      'dpo_table_id': instance.tableId,
      'dpo_table': instance.dpoTable,
      'column': instance.column,
      'is_active': instance.isActive,
      'related_table': instance.relatedTable,
    };
