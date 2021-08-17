class BookingItem {
  const BookingItem({
    required this.poster,
    required this.title,
    this.price,
    required this.location,
  });

  factory BookingItem.fromJson(dynamic json) {
    return BookingItem(
      poster: json['poster'].toString(),
      title: json['name'].toString(),
      location: json['location'].toString(),
    );
  }

  final String title;
  final String poster;
  final double? price;
  final String location;
}

final List<BookingItem> bookingItemsMockData = <BookingItem>[
  const BookingItem(
    title: 'Durian Party Night',
    location: 'Impian Emas',
    price: 5.00,
    poster:
        "https://res.cloudinary.com/dpjso4bmh/image/upload/v1626869043/pengo/penger/logo/ie2lz02i7f5w6eqysvnm.png",
  ),
];
