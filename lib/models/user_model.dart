// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User extends Equatable {
  const User({
    this.id = "0",
    this.useremail = "",
    this.password = "",
    this.isVerified = false,
  });

  final String id;
  final String useremail;
  final String password;
  final bool isVerified;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        useremail: json["useremail"],
        password: json["password"],
        isVerified: json["isVerified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "useremail": useremail,
        "password": password,
        "isVerified": isVerified,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, useremail, password, isVerified];
}
