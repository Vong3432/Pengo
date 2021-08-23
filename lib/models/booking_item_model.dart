class BookingItem {
  const BookingItem({
    required this.poster,
    required this.isActive,
    required this.title,
    required this.id,
    this.price,
    this.location,
  });

  factory BookingItem.fromJson(dynamic json) {
    return BookingItem(
      id: json['id'] as int,
      isActive: json['is_active'] as bool,
      poster: json['poster_url'].toString(),
      title: json['name'].toString(),
      location: json['location'] != null ? json['location'].toString() : null,
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["title"] = title;
    map["poster"] = poster;
    map["price"] = price;
    map["location"] = location;
    // Add all other fields
    return map;
  }

  final int id;
  final bool isActive;
  final String title;
  final String poster;
  final double? price;
  final String? location;
}

final List<BookingItem> bookingItemsMockData = <BookingItem>[
  const BookingItem(
    isActive: true,
    id: 9999,
    title: 'Durian Party Night',
    location: 'Impian Emas',
    price: 5.00,
    poster:
        "https://res.cloudinary.com/dpjso4bmh/image/upload/v1626869043/pengo/penger/logo/ie2lz02i7f5w6eqysvnm.png",
  ),
];
