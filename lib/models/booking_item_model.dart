import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/geolocation_model.dart';
import 'package:pengo/models/geolocation_model.dart';

part 'booking_item_model.g.dart';

@JsonSerializable()
class BookingItem extends Equatable {
  BookingItem({
    required this.poster,
    required this.isActive,
    required this.title,
    required this.id,
    this.price,
    this.availableFrom,
    this.availableTo,
    this.startFrom,
    this.endAt,
    this.isPreserveable,
    this.isTransferable,
    this.isCountable,
    this.isDiscountable,
    this.maxTransfer,
    this.maxBook,
    this.preservedBook,
    this.creditPoints,
    this.quantity,
    this.discountAmount,
    this.categoryId,
    this.description,
    this.geolocation,
  });

  factory BookingItem.fromJson(Map<String, dynamic> json) {
    final BookingItem t = _$BookingItemFromJson(json);
    if (t.geolocation != null) {
      t.location = t.geolocation!.name;
    }
    return t;
  }
  Map<String, dynamic> toJson() => _$BookingItemToJson(this);

  final int id;

  @JsonKey(name: 'is_active')
  final bool isActive;

  @JsonKey(name: 'name')
  final String title;

  @JsonKey(name: 'poster_url')
  final String poster;

  final double? price;

  @JsonKey(ignore: true, fromJson: null, toJson: null)
  String? location;

  @JsonKey(name: 'available_from', includeIfNull: false)
  final String? availableFrom;

  @JsonKey(name: 'available_to', includeIfNull: false)
  final String? availableTo;

  @JsonKey(name: 'start_from', includeIfNull: false)
  final DateTime? startFrom;

  @JsonKey(name: 'end_at', includeIfNull: false)
  final DateTime? endAt;

  @JsonKey(name: 'is_preservable')
  final bool? isPreserveable;

  @JsonKey(name: 'is_transferable')
  final bool? isTransferable;

  @JsonKey(name: 'is_countable')
  final bool? isCountable;

  @JsonKey(name: 'is_discountable')
  final bool? isDiscountable;

  @JsonKey(name: 'maximum_transfer')
  final int? maxTransfer;

  @JsonKey(name: 'maximum_book')
  final int? maxBook;

  @JsonKey(name: 'preserved_book')
  final int? preservedBook;

  @JsonKey(name: 'credit_points')
  final double? creditPoints;

  final int? quantity;

  @JsonKey(name: 'discount_amount')
  final double? discountAmount;

  @JsonKey(name: 'booking_category_id')
  final int? categoryId;

  @JsonKey(includeIfNull: false)
  final String? description;

  @JsonKey(name: 'geolocation', includeIfNull: false)
  final Geolocation? geolocation;

  @override
  // TODO: implement props
  List<Object> get props => [id];
}
