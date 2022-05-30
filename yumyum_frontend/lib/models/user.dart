import 'package:flutter/foundation.dart';

class User {
  String userId;
  String name;
  String username;
  String password;
  String address;
  String email;
  String profileImage;

  User({
    @required this.userId,
    @required this.name,
    @required this.username,
    @required this.password,
    @required this.address,
    @required this.email,
    @required this.profileImage,
  });

  User.fromJson(Map<String, dynamic> json)
      : this(
          userId: json['_id'],
          name: json['name'],
          username: json['username'],
          password: json['password'],
          address: json['address'],
          email: json['email'],
          profileImage: json['profileImage'],
        );

  Map<String, dynamic> toJson() => {
        '_id': userId,
        'name': name,
        'username': username,
        'password': password,
        'address': address,
        'email': email,
        'profileImage': profileImage,
      };
}
