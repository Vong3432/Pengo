import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/location_model.dart';
import 'package:pengo/models/review.dart';

class Penger {
  const Penger(
      {required this.name,
      required this.logo,
      required this.items,
      required this.description,
      required this.location,
      required this.reviews});

  factory Penger.fromJson(dynamic json) {
    var items =
        json['booking_items'] == null ? [] : json['booking_items'] as List;
    var reviews = json['reviews'] == null ? [] : json['reviews'] as List;

    List<BookingItem> itemList =
        items.map((i) => BookingItem.fromJson(i)).toList();
    List<Review> reviewList = reviews.map((i) => Review.fromJson(i)).toList();

    return Penger(
        name: json["name"].toString(),
        logo: json["logo"].toString(),
        items: itemList,
        description:
            json['description'] == null ? "" : json['description'].toString(),
        location: Location.fromJson(json['location']),
        reviews: reviewList);
  }

  final String name;
  final String logo;
  final String? description;
  final Location location;
  final List<Review> reviews;
  final List<BookingItem> items;
}

final List<Penger> pengersMockingData = <Penger>[
  const Penger(
      logo: "",
      name: "GG.com org",
      description: "lorem",
      location: Location(lat: 122, lng: 122, location: "Sutera Impian"),
      reviews: <Review>[
        Review(title: "Nice service", description: "The staff are very kind")
      ],
      items: <BookingItem>[
        BookingItem(
          title: "Durian party night",
          location: "Impian Emas",
          poster:
              "https://res.cloudinary.com/dpjso4bmh/image/upload/v1626869043/pengo/penger/logo/ie2lz02i7f5w6eqysvnm.png",
        ),
      ]),
];
