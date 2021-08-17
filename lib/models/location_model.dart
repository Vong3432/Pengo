class Location {
  const Location(
      {required this.lat, required this.lng, required this.location});

  factory Location.fromJson(dynamic json) {
    return Location(
      location: json['address'].toString(),
      lat: json['geolocation']['latitude'] as double,
      lng: json['geolocation']['longitude'] as double,
    );
  }

  final String location;
  final double lat;
  final double lng;
}
