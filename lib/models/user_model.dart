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
    this.email = "",
    this.password = "",
    this.firstName = "",
    this.lastName = "",
    this.phoneNumber = "",
    this.address = "",
    this.isVerified = false,
  });

  final String id;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final bool isVerified;

  factory User.fromJson(dynamic json) => User(
        id: json["id"].toString(),
        email: json["email"],
        password: json["password"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        isVerified: json["isVerified"],
      );

  Map<String, dynamic> toJson() => {
        "id": int.parse(id),
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "address": address,
        "isVerified": isVerified,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, email, password, isVerified];
}
