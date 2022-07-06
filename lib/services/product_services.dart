import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_shop_app/models/product_model.dart';

Future<List<Product>> fetchProducts() async {
  final response = await http.get(
    Uri.parse('https://localhost:7296/api/Product'),
    headers: <String, String>{
      'Content-Type': "application/json;charset=UTF-8",
    },
  );
  if (response.statusCode == 200) {
    List<Product> products = productsFromJson(utf8.decode(response.bodyBytes));
    return products;
  } else {
    throw Exception('Failed to load products');
  }
}
