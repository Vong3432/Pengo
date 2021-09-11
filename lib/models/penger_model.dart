import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/location_model.dart';
import 'package:pengo/models/review.dart';
import 'package:pengo/models/user_model.dart';

part 'penger_model.g.dart';

@JsonSerializable()
class Penger {
  const Penger({
    required this.id,
    required this.name,
    required this.logo,
    required this.items,
    required this.description,
    required this.location,
    // required this.reviews,
  });

  factory Penger.fromJson(Map<String, dynamic> json) => _$PengerFromJson(json);
  Map<String, dynamic> toJson() => _$PengerToJson(this);

  final int id;
  final String name;
  final String logo;
  final String? description;
  final Location location;
  // final List<Review> reviews;

  @JsonKey(name: 'booking_items')
  final List<BookingItem> items;
}

// final List<Penger> pengersMockingData = <Penger>[
//   Penger(
//       id: 9999,
//       logo: "",
//       name: "GG.com org",
//       description: "lorem",
//       location: const Location(
//           lat: 122,
//           lng: 122,
//           location: "Sutera Impian",
//           street: "12, Jalan Eco Botanic"),
//       reviews: <Review>[
//         Review(
//           title: "Nice service",
//           description: "The staff are very kind",
//           user: userMockDataList[0],
//           date: "12 Jul 2021",
//         )
//       ],
//       items: <BookingItem>[
//         BookingItem(
//           isActive: true,
//           id: 9999,
//           title: "Durian party night",
//           location: "Impian Emas",
//           poster:
//               "https://res.cloudinary.com/dpjso4bmh/image/upload/v1626869043/pengo/penger/logo/ie2lz02i7f5w6eqysvnm.png",
//         ),
//       ]),
// ];
