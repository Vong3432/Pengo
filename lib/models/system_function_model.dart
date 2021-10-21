import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/booking_category_model.dart';

part 'system_function_model.g.dart';

@JsonSerializable()
class SystemFunction extends Equatable {
  const SystemFunction({
    required this.name,
    required this.description,
    required this.isActive,
    required this.isPremium,
    this.price,
    this.id,
  });

  factory SystemFunction.fromJson(Map<String, dynamic> json) =>
      _$SystemFunctionFromJson(json);
  Map<String, dynamic> toJson() => _$SystemFunctionToJson(this);

  final int? id;

  @JsonKey(name: 'is_premium')
  final bool isPremium;

  @JsonKey(name: 'is_active')
  final bool isActive;

  final double? price;

  final String name;
  final String description;

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
