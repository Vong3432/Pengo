class User {
  const User({
    required this.username,
    required this.avatar,
  });

  factory User.fromJson(dynamic json) {
    return User(
      username: json['username'].toString(),
      avatar: json['avatar'].toString(),
    );
  }

  final String username;
  final String avatar;
}

final List<User> userMockDataList = <User>[
  const User(
      username: "johndoe",
      avatar:
          "https://images.unsplash.com/photo-1601455763557-db1bea8a9a5a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGF2YXRhcnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60"),
  const User(
      username: "michelletan123",
      avatar:
          "https://images.unsplash.com/photo-1558898479-33c0057a5d12?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1350&q=80"),
  const User(
      username: "NotKittyForReal",
      avatar:
          "https://images.unsplash.com/photo-1526336024174-e58f5cdd8e13?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Y2F0fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60"),
  const User(
      username: "Human 1",
      avatar:
          "https://images.unsplash.com/photo-1589182337358-2cb63099350c?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YWxwYWNhfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60"),
];
