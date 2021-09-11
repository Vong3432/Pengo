import 'package:json_annotation/json_annotation.dart';

part 'geolocation_model.g.dart';

@JsonSerializable()
class Geolocation {
  Geolocation(this.latitude, this.longitude, this.name);

  factory Geolocation.fromJson(Map<String, dynamic> json) =>
      _$GeolocationFromJson(json);
  Map<String, dynamic> toJson() => _$GeolocationToJson(this);

  final double latitude;
  final double longitude;

  @JsonKey(includeIfNull: false)
  final String? name;
}
