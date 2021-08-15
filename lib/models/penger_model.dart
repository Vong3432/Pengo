import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/review.dart';
import 'package:pengo/ui/home/widgets/penger_item.dart';

class Penger {
  const Penger(
      {required this.name,
      required this.items,
      required this.description,
      required this.location,
      required this.reviews});

  final String name;
  final String description;
  final String location;
  final List<Review> reviews;
  final List<BookingItem> items;
}

final List<Penger> pengersMockingData = <Penger>[
  const Penger(
      name: "GG.com org",
      description: "lorem",
      location: "17, Jalan Botanic, 5/12 Taman Botanic",
      reviews: <Review>[
        Review(title: "Nice service", description: "The staff are very kind")
      ],
      items: <BookingItem>[
        BookingItem(title: "Durian party night", location: "Impian Emas"),
        BookingItem(title: "Durian party night", location: "Impian Emas"),
        BookingItem(title: "Durian party night", location: "Impian Emas"),
        BookingItem(title: "Durian party night", location: "Impian Emas"),
      ]),
];
