import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/dpo_table_model.dart';

part 'dpo_column_model.g.dart';

@JsonSerializable()
class DpoColumn {
  DpoColumn({
    this.id,
    required this.tableId,
    required this.column,
    required this.isActive,
    this.relatedTable,
    this.dpoTable,
  });

  factory DpoColumn.fromJson(Map<String, dynamic> json) =>
      _$DpoColumnFromJson(json);
  Map<String, dynamic> toJson() => _$DpoColumnToJson(this);

  final int? id;

  @JsonKey(name: "dpo_table_id")
  final int tableId;

  @JsonKey(name: "dpo_table")
  final DpoTable? dpoTable;

  final String column;

  @JsonKey(name: "is_active")
  final bool isActive;

  @JsonKey(name: "related_table")
  final DpoTable? relatedTable;
}
