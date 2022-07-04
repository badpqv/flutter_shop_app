import 'dart:convert';

import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:http/http.dart' as http;

String cartApiUrl =
    "https://62bd4f38bac21839b600258a.mockapi.io/shop_app/shopping_cart";
Future<List<Cart>> fetchCarts() async {
  final response = await http.get(
    Uri.parse(cartApiUrl),
    headers: <String, String>{
      'Content-Type': "application/json;charset=UTF-8",
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the J
    // SON.s
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    List<Cart> carts;

    if (jsonData.length > 0) {
      carts = jsonData.map((cart) => Cart.fromJson(cart)).toList();
    } else {
      carts = <Cart>[];
    }
    return carts;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load carts');
  }
}

Future<Cart> fetchCart(String id) async {
  final response = await http.get(
    Uri.parse("$cartApiUrl?/$id"),
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
      return Cart(product: const Product(), quantity: 0, id: "0");
    }
    return Cart.fromJson(jsonDecode(response.body)[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load cart');
  }
}

Future<http.Response> postCart(
    Cart cart, int addedQuantity, bool isExisted) async {
  http.Response response;
  try {
    if (isExisted == false) {
      response = await http.post(
        Uri.parse(cartApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "product": cart.product,
            "quantity": cart.quantity,
          },
        ),
      );
      return response;
    } else {
      var response = await http.put(
        Uri.parse('$cartApiUrl/${cart.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "product": cart.product,
            "quantity": cart.quantity + addedQuantity,
          },
        ),
      );
      return response;
    }
  } catch (e) {
    throw Exception('Failed to add carts');
  }
}

Future<http.Response> editCart(Cart cart) async {
  try {
    var response = await http.put(
      Uri.parse('${cartApiUrl}/${cart.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          "product": cart.product,
          "quantity": cart.quantity + 1,
        },
      ),
    );
    return response;
  } catch (e) {
    throw Exception('Failed to add carts');
  }
}

Future<Cart> deleteCart(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('$cartApiUrl/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Cart.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete cart.');
  }
}
