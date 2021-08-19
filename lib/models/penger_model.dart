import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/location_model.dart';
import 'package:pengo/models/review.dart';
import 'package:pengo/models/user_model.dart';

class Penger {
  const Penger(
      {required this.id,
      required this.name,
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
      id: json["id"] as int,
      name: json["name"].toString(),
      logo: json["logo"].toString(),
      items: itemList,
      description:
          json['description'] == null ? "" : json['description'].toString(),
      location: Location.fromJson(json['location']),
      // reviews: reviewList,
      reviews: <Review>[
        Review(
          title: "Nice service",
          description:
              "This is the closest Switch to the hotel I am staying at and decided to go there despite the numerous poor reviews. Fortunately I was greeted by a lady sales staff when I entered the store that was enthusiastic and knowledgeable about the watch I wanted to purchase as she was wearing an Apple Watch herself.  Happy with my purchase and the good level of service I received.",
          user: userMockDataList[0],
          date: "19 Aug 2021",
        ),
        Review(
          title: "Good service",
          description:
              """Bought an item online and did a store pick up on the same day. Kudos to them for willing to replace me the same item with a different design. What I didn't like was the multiple excuses they gave to prevent from swapping.""",
          user: userMockDataList[2],
          date: "15 Aug 2021",
        ),
        Review(
          title: "The best service for customers experience. ",
          description:
              "Staff very helpful and served like professional. Recommended for everyone to buy Apple device at this store. Good job !",
          user: userMockDataList[1],
          date: "7 July 2021",
        ),
        Review(
          title: "Nice service",
          description:
              "The best branch ever! Staff is super friendly and helpful all the time!",
          user: userMockDataList[3],
          date: "28 May 2021",
        ),
      ],
    );
  }

  final int id;
  final String name;
  final String logo;
  final String? description;
  final Location location;
  final List<Review> reviews;
  final List<BookingItem> items;
}

final List<Penger> pengersMockingData = <Penger>[
  Penger(
      id: 9999,
      logo: "",
      name: "GG.com org",
      description: "lorem",
      location: const Location(
          lat: 122,
          lng: 122,
          location: "Sutera Impian",
          street: "12, Jalan Eco Botanic"),
      reviews: <Review>[
        Review(
          title: "Nice service",
          description: "The staff are very kind",
          user: userMockDataList[0],
          date: "12 Jul 2021",
        )
      ],
      items: <BookingItem>[
        BookingItem(
          isActive: true,
          id: 9999,
          title: "Durian party night",
          location: "Impian Emas",
          poster:
              "https://res.cloudinary.com/dpjso4bmh/image/upload/v1626869043/pengo/penger/logo/ie2lz02i7f5w6eqysvnm.png",
        ),
      ]),
];
