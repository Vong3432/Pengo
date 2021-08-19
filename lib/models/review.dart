import 'package:pengo/models/user_model.dart';

class Review {
  const Review({
    required this.title,
    required this.date,
    this.description,
    required this.user,
  });

  factory Review.fromJson(dynamic json) {
    return Review(
      title: json['name'].toString(),
      description: json['location'].toString(),
      user: User.fromJson(
        json['user'],
      ),
      date: json['created_at'].toString(),
    );
  }

  final String title;
  final User user;
  final String date;
  final String? description;
}
