class BookingItem {
  const BookingItem({required this.title, this.price, required this.location});

  final String title;
  final double? price;
  final String location;
}

final List<BookingItem> bookingItemsMockData = <BookingItem>[
  const BookingItem(
      title: 'Durian Party Night', location: 'Impian Emas', price: 5.00),
  const BookingItem(
      title: 'Durian Party Night', location: 'Impian Emas', price: 5.00),
  const BookingItem(
      title: 'Durian Party Night', location: 'Impian Emas', price: 5.00),
];
