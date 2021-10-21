import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/dpo_column_model.dart';

part 'dpo_table_model.g.dart';

@JsonSerializable()
class DpoTable {
  DpoTable({
    this.id,
    required this.tableName,
    required this.isActive,
    this.dpoColumns,
  });

  factory DpoTable.fromJson(Map<String, dynamic> json) =>
      _$DpoTableFromJson(json);
  Map<String, dynamic> toJson() => _$DpoTableToJson(this);

  final int? id;

  @JsonKey(name: "table_name")
  final String tableName;

  @JsonKey(name: "is_active")
  final bool isActive;

  @JsonKey(name: "dpo_cols")
  final List<DpoColumn>? dpoColumns;
}
