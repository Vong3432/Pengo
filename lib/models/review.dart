class Review {
  const Review({required this.title, this.description});

  factory Review.fromJson(dynamic json) {
    return Review(
      title: json['name'].toString(),
      description: json['location'].toString(),
    );
  }

  final String title;
  final String? description;
}
