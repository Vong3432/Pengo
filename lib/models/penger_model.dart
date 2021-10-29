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
    this.items,
    this.description,
    this.location,
    // required this.reviews,
  });

  factory Penger.fromJson(Map<String, dynamic> json) => _$PengerFromJson(json);
  Map<String, dynamic> toJson() => _$PengerToJson(this);

  final int id;
  final String name;
  final String logo;
  final String? description;
  final Location? location;
  // final List<Review> reviews;

  @JsonKey(name: 'booking_items')
  final List<BookingItem>? items;
}
