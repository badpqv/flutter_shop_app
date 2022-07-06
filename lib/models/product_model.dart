import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';

List<Product> productsFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product extends Equatable {
  final String id;
  final String title, description;
  final String images;
  final String colors;
  final double rating, price;
  final bool isFavourite, isPopular;
  final String categoryId;
  const Product({
    required this.id,
    this.images = '',
    this.colors = '',
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    this.title = "",
    this.price = 0.0,
    this.description = "",
    this.categoryId = "0",
  });

  factory Product.fromJson(dynamic json) {
    return Product(
      id: json["id"].toString(),
      images: (json["images"].toString()),
      colors: (json["colors"].toString()),
      rating: (json['rating'] as num).toDouble(),
      isFavourite: json['isFavourite'] as bool,
      isPopular: json['isPopular'] as bool,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      categoryId: json["categoryId"].toString(),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": int.parse(id),
        "title": title,
        "description": description,
        "images": images,
        "colors": colors,
        "rating": rating,
        "price": price,
        "isFavourite": isFavourite,
        "isPopular": isPopular,
        "categoryId": categoryId
      };
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        images,
        colors,
        rating,
        isFavourite,
        isPopular,
        title,
        price,
        description,
      ];
}
