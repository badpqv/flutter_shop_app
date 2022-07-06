import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_shop_app/models/category_model.dart';

const categoryApiUrl = "https://localhost:7296/api/Category";
Future<List<Category>> fetchCategories() async {
  final response = await http.get(
    Uri.parse(categoryApiUrl),
    headers: <String, String>{
      'Content-Type': "application/json;charset=UTF-8",
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the J
    // SON.s
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    List<Category> categories =
        categoryFromJson(utf8.decode(response.bodyBytes));
    return categories;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load category');
  }
}
