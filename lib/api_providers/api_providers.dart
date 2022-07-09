import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final List<String> urls = [
    Platform.isAndroid
        ? "https://192.168.1.3:5000/api/User"
        : "https://localhost:5000/api/User",
    Platform.isAndroid
        ? "https://192.168.1.3:5000/api/Product"
        : "https://localhost:5000/api/Product",
    Platform.isAndroid
        ? "https://192.168.1.3:5000/api/Category"
        : "https://localhost:5000/api/Category",
    Platform.isAndroid
        ? "https://192.168.1.3:5000/api/Cart"
        : "https://localhost:5000/api/Cart",
  ];

  //FETCH
  Future<List<User>> fetchUsersList() async {
    try {
      Response response = await _dio.get(urls[0]);
      return userFromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return <User>[];
    }
  }

  Future<List<Product>> fetchProductsList() async {
    try {
      Response response = await _dio.get(urls[1]);
      return productsFromJson(jsonEncode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return <Product>[];
    }
  }

  Future<List<Category>> fetchCategoriesList() async {
    try {
      Response response = await _dio.get(urls[2]);
      return categoryFromJson(jsonEncode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return <Category>[];
    }
  }

  Future<List<Cart>> fetchCartsList() async {
    try {
      Response response = await _dio.get(urls[3]);
      return cartFromJson(jsonEncode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return <Cart>[];
    }
  }

  Future<List<Cart>> fetchCurrentUserCart(User user) async {
    try {
      Response response = await _dio.get(urls[3]);
      return cartFromJson(jsonEncode(response.data))
          .where((element) => element.user == user)
          .toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return <Cart>[];
    }
  }

  //POST
  Future<User> register(User user) async {
    var data = user.toJson();

    try {
      Response response = await _dio.post(urls[0], data: data);
      return User.fromJson(response.data);
    } catch (e, stacktrace) {
      print("Exception occured: $e stackTrace: $stacktrace");
      return const User();
    }
  }

  Future<User> login(User user) async {
    try {
      var data = user.toJson();
      Response response = await _dio.post("${urls[0]}/login", data: data);
      return User.fromJson(response.data);
    } catch (e) {
      print(e);
      return const User();
    }
  }

  Future<bool> postProduct(Product product) async {
    var data = product.toJson();

    try {
      Response response = await _dio.post(urls[1], data: data);
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e, stacktrace) {
      print("Exception occured: $e stackTrace: $stacktrace");
      return false;
    }
  }

  Future<bool> postCategory(Category category) async {
    var data = category.toJson();

    try {
      Response response = await _dio.post(
        urls[2],
        data: data,
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e, stacktrace) {
      print("Exception occured: $e stackTrace: $stacktrace");
      return false;
    }
  }

  Future<bool> postCart(Cart cart) async {
    var data = cart.toJson();
    try {
      Response response = await _dio.post(
        urls[3],
        data: data,
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e, stacktrace) {
      print("Exception occured: $e stackTrace: $stacktrace");
      return false;
    }
  }

  //PUT
  Future<User> editUser(User user, int id) async {
    var data = FormData.fromMap({'data': jsonEncode(user.toJson())});

    try {
      Response response = await _dio.put("${urls[0]}/$id", data: data);
      return response.data;
    } catch (e, stacktrace) {
      print("Exception occured: $e stackTrace: $stacktrace");
      return const User();
    }
  }

  Future<Product> editProduct(Product product, int id) async {
    var data = FormData.fromMap({'data': jsonEncode(product.toJson())});

    try {
      Response response = await _dio.put("${urls[0]}/$id", data: data);
      return response.data;
    } catch (e, stacktrace) {
      print("Exception occured: $e stackTrace: $stacktrace");
      return const Product(id: "0");
    }
  }

  Future<Category> editCategory(Category category, int id) async {
    var data = FormData.fromMap({'data': jsonEncode(category.toJson())});

    try {
      Response response = await _dio.put("${urls[0]}/$id", data: data);
      return response.data;
    } catch (e, stacktrace) {
      print("Exception occured: $e stackTrace: $stacktrace");
      return const Category();
    }
  }

  Future<Cart> editCart(Cart cart, int id) async {
    var data = FormData.fromMap({'data': jsonEncode(cart.toJson())});

    try {
      Response response = await _dio.put("${urls[0]}/$id", data: data);
      return response.data;
    } catch (e, stacktrace) {
      print("Exception occured: $e stackTrace: $stacktrace");
      return Cart(id: "0", productId: "0", userId: "0", user: const User());
    }
  }

  //DELETE
  Future<int> deleteUser() async {
    try {
      Response response = await _dio.delete(urls[0]);
      return response.statusCode!;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 400;
    }
  }

  Future<int> deleteProduct() async {
    try {
      Response response = await _dio.delete(urls[1]);
      return response.statusCode!;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 400;
    }
  }

  Future<int> deleteCategory() async {
    try {
      Response response = await _dio.get(urls[2]);
      return response.statusCode!;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 400;
    }
  }

  Future<List<Cart>> deleteCart(int id, User user) async {
    try {
      Response response = await _dio.delete("${urls[3]}/$id");
      return cartFromJson(jsonEncode(response.data))
          .where((element) => element.user == user)
          .toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return <Cart>[];
    }
  }
}
