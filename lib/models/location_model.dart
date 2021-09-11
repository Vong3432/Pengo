import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/geolocation_model.dart';

part 'location_model.g.dart';

@JsonSerializable()
class Location {
  const Location({
    required this.geolocation,
    required this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  final Geolocation geolocation;
  final String address;
}
