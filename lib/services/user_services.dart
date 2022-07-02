import 'dart:convert';

import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:http/http.dart' as http;

String usersApiUrl =
    "https://62bd4f38bac21839b600258a.mockapi.io/shop_app/users";
Future<List<User>> fetchUsers() async {
  final response = await http.get(
    Uri.parse(usersApiUrl),
    headers: <String, String>{
      'Content-Type': "application/json;charset=UTF-8",
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the J
    // SON.s
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    List<User> users;

    if (jsonData.isNotEmpty) {
      users = jsonData.map((user) => User.fromJson(user)).toList();
    } else {
      users = <User>[];
    }
    return users;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load users');
  }
}

Future<User> fetchUser(String id) async {
  final response = await http.get(
    Uri.parse("$usersApiUrl?/$id"),
    headers: <String, String>{
      'Content-Type': "application/json;charset=UTF-8",
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the J
    // SO
    var emptMap = <String, dynamic>{};
    var jsonresponse = jsonDecode(response.body).toString();
    if (jsonresponse.length <= 2) {
      return User(useremail: "", password: "", id: "");
    }
    return User.fromJson(jsonDecode(response.body)[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}

Future<bool> login(User user) async {
  try {
    var response = await http.get(
      Uri.parse(usersApiUrl),
      headers: <String, String>{
        'Content-Type': "application/json;charset=UTF-8",
      },
    );
    if (response.statusCode == 200) {
      List<User> users = userFromJson(utf8.decode(response.bodyBytes));
      var isExisted = users.contains(user);

      return isExisted;
    }
    return false;
  } catch (e) {
    throw Exception('Failed to login');
  }
}
