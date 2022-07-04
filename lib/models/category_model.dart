// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  const Category({
    this.title = "",
    this.icon = "",
    this.id = "0",
  });

  final String title;
  final String icon;
  final String id;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        title: json["title"],
        icon: json["icon"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "icon": icon,
        "id": id,
      };
}
