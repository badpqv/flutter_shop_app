import 'dart:convert';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:http/http.dart' as http;

String usersApiUrl = "https://localhost:7296/api/User";
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

Future<User> login(User user) async {
  try {
    var response = await http.get(
      Uri.parse(usersApiUrl),
      headers: <String, String>{
        'Content-Type': "application/json;charset=UTF-8",
      },
    );
    if (response.statusCode == 200) {
      List<User> users = userFromJson(utf8.decode(response.bodyBytes))
          .where((element) =>
              element.email == user.email && element.password == user.password)
          .toList();
      return users.isNotEmpty ? users[0] : const User();
    }
    return const User();
  } catch (e) {
    print(e);
    return const User();
  }
}
