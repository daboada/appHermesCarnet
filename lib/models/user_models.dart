// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? message;
  String? token;
  String? username;

  User({
    this.message,
    this.token,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        message: json["message"],
        token: json["token"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "username": username,
      };
}