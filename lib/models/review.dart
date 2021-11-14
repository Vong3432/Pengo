import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/models/user_model.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  const Review({
    required this.id,
    required this.title,
    required this.bookingRecordId,
    required this.category,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.record,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
  final int id;
  final String title;
  final String description;

  @JsonKey(name: 'booking_record_id')
  final int bookingRecordId;

  final BookingRecord? record;

  final String category;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
}
