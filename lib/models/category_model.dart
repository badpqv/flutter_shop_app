// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_shop_app/models/product_model.dart';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  const Category({
    this.title = "",
    this.icon = "",
    this.id = "0",
    this.products = const <Product>[],
  });

  final String title;
  final String icon;
  final String id;
  final List<Product> products;

  factory Category.fromJson(dynamic json) => Category(
        title: json["title"],
        icon: json["icon"],
        id: json["id"].toString(),
        products: List<Product>.from(
          json["products"].map(
            (x) => Product.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "icon": icon,
        "id": int.parse(id),
      };
}
