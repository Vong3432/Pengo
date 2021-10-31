// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    username: json['username'] as String,
    avatar: json['avatar'] as String,
    id: json['id'] as int,
    email: json['email'] as String,
    phone: json['phone'] as String,
    locations: (json['locations'] as List<dynamic>?)
        ?.map((e) => UserLocation.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'avatar': instance.avatar,
      'locations': instance.locations,
    };

UserLocation _$UserLocationFromJson(Map<String, dynamic> json) {
  return UserLocation(
    address: json['address'] as String?,
    street: json['street'] as String?,
    geolocation: json['geolocation'] == null
        ? null
        : Geolocation.fromJson(json['geolocation'] as Map<String, dynamic>),
    isFav: json['is_fav'] as bool,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$UserLocationToJson(UserLocation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'street': instance.street,
      'geolocation': instance.geolocation,
      'is_fav': instance.isFav,
    };
