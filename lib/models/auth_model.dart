import 'package:json_annotation/json_annotation.dart';
import 'package:pengo/models/token.dart';
import 'package:pengo/models/user_model.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class Auth {
  Auth({
    required this.user,
    required this.tokenData,
  });

  // factory Auth.fromJson(dynamic json) {
  //   final dynamic user = json['user'];
  //   return Auth(
  //     id: user['id'] as int,
  //     username: user['username'].toString(),
  //     avatar: user['avatar'].toString(),
  //     phone: user['phone'].toString(),
  //     email: user['email'].toString(),
  //     token: json['token']['token'].toString(),
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   var map = new Map<String, dynamic>();
  //   map["id"] = id;
  //   map["username"] = username;
  //   map["avatar"] = avatar;
  //   map["phone"] = phone;
  //   map["email"] = email;
  //   map["token"] = token;
  //   // Add all other fields
  //   return map;
  // }

  factory Auth.fromJson(Map<String, dynamic> json) {
    final Auth t = _$AuthFromJson(json);
    t.token = t.tokenData.token;
    t.phone = t.user.phone;
    t.username = t.user.username;
    t.avatar = t.user.avatar;
    t.email = t.user.email;
    return t;
  }
  Map<String, dynamic> toJson() => _$AuthToJson(this);

  @JsonKey(toJson: null, fromJson: null, ignore: true)
  late String phone;

  @JsonKey(toJson: null, fromJson: null, ignore: true)
  late String avatar;

  @JsonKey(toJson: null, fromJson: null, ignore: true)
  late String username;

  @JsonKey(name: 'user')
  final User user;

  @JsonKey(name: 'token')
  final Token tokenData;

  @JsonKey(toJson: null, fromJson: null, ignore: true)
  late String email;

  @JsonKey(ignore: true, fromJson: null, toJson: null)
  String? token;
}
