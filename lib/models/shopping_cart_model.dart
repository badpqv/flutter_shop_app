import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/nofification_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import "dart:convert";

import 'package:flutter_shop_app/models/user_model.dart';

List<Cart> cartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  Cart({
    this.product = const Product(id: "0"),
    this.quantity = 1,
    this.id = "0",
    required this.productId,
    required this.userId,
    required this.user,
  });

  final Product product;
  final int quantity;
  final String id;
  final String userId;
  final String productId;
  final User user;

  factory Cart.fromJson(dynamic json) => Cart(
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
        id: json["id"].toString(),
        userId: json["userId"].toString(),
        productId: json["productId"].toString(),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "id": int.parse(id),
        "userId": int.parse(userId),
        "productId": int.parse(productId),
      };
}
