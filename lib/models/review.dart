import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/user_model.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  const Review({
    required this.id,
    required this.title,
    required this.date,
    this.description,
    required this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
  final int id;
  final String title;
  final User user;
  final String date;
  final String? description;
}

List<Review> fakedReviews = [
  Review(
    id: 9999,
    title: "Nice service",
    description: "The staff are very kind",
    user: userMockDataList[0],
    date: "12 Jul 2021",
  ),
];
