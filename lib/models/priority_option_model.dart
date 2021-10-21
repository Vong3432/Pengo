import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/dpo_column_model.dart';

part 'priority_option_model.g.dart';

@JsonSerializable()
class PriorityOption {
  const PriorityOption(
      {required this.conditions, required this.dpoColumn, required this.value});

  factory PriorityOption.fromJson(Map<String, dynamic> json) =>
      _$PriorityOptionFromJson(json);
  Map<String, dynamic> toJson() => _$PriorityOptionToJson(this);

  final String conditions;

  @JsonKey(name: 'dpo_col')
  final DpoColumn dpoColumn;

  final String value;
}
