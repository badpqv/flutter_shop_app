import 'dart:convert';
import 'dart:developer';

import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:http/http.dart' as http;

String cartApiUrl = "https://localhost:7296/api/Cart";
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

Future<List<Cart>> fetchCartsWithUser(User user) async {
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

    if (jsonData.isNotEmpty) {
      carts = jsonData
          .map((cart) => Cart.fromJson(cart))
          .where((element) => element.user == user)
          .toList();
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
      return Cart(
        product: const Product(id: "0"),
        quantity: 0,
        id: "0",
        userId: "0",
        productId: "0",
        user: const User(),
      );
    }
    return Cart.fromJson(jsonDecode(response.body)[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load cart');
  }
}

Future<bool> postCart(Cart cart, bool isExisted) async {
  http.Response response;
  try {
    if (isExisted == false) {
      response = await http.post(
        Uri.parse(cartApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(cart.toJson()),
      );
      return response.statusCode == 200;
    }
    int statusCode = 0;
    await editCart(cart).then(
      (value) => statusCode = value.statusCode,
    );
    return statusCode == 200;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<http.Response> editCart(
  Cart cart,
) async {
  try {
    var response = await http.put(
      Uri.parse('$cartApiUrl/${cart.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        cart.toJson(),
      ),
    );
    return response;
  } catch (e) {
    throw Exception('Failed to add carts');
  }
}

Future<bool> deleteCart(int id) async {
  try {
    final http.Response response = await http.delete(
      Uri.parse('$cartApiUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}
