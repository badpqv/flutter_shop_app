import 'package:equatable/equatable.dart';
import 'dart:convert';

List<Product> productsFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product extends Equatable {
  final String id;
  final String title, description;
  final List<String> images;
  final List<String> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  const Product({
    this.id = "0",
    this.images = const [],
    this.colors = const [],
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    this.title = "",
    this.price = 0.0,
    this.description = "",
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      images: List<String>.from(json["images"].map((x) => x)),
      colors: (json['colors'] as List<dynamic>).cast<String>(),
      rating: (json['rating'] as num).toDouble(),
      isFavourite: json['isFavourite'] as bool,
      isPopular: json['isPopular'] as bool,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
    );
  }
  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
        "colors": colors,
        "rating": rating,
        "price": price,
        "isFavourite": isFavourite,
        "isPopular": isPopular,
        "id": id,
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
