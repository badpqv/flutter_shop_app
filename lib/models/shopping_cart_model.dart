import 'package:flutter_shop_app/models/product_model.dart';
import "dart:convert";

List<Cart> cartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  Cart({
    this.product = const Product(),
    this.quantity = 1,
    this.id = "0",
  });

  final Product product;
  final int quantity;
  final String id;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "quantity": quantity,
        "id": id,
      };
}
