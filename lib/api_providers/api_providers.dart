import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final List<String> urls = [
    Platform.isAndroid
        ? "http://192.168.1.2:5000/api/User"
        : "http://localhost:5000/api/User",
    Platform.isAndroid
        ? "http://192.168.1.2:5000/api/Product"
        : "http://localhost:5000/api/Product",
    Platform.isAndroid
        ? "http://192.168.1.2:5000/api/Category"
        : "http://localhost:5000/api/Category",
    Platform.isAndroid
        ? "http://192.168.1.2:5000/api/Cart"
        : "http://localhost:5000/api/Cart",
  ];

  //FETCH
  Future<List<User>> fetchUsersList() async {
    try {
      Response response = await _dio.get(urls[0]);
      return userFromJson(response.data);
    } catch (error, stacktrace) {
      return <User>[];
    }
  }

  Future<List<Product>> fetchProductsList() async {
    try {
      Response response = await _dio.get(urls[1]);
      return productsFromJson(jsonEncode(response.data));
    } catch (error, stacktrace) {
      return <Product>[];
    }
  }

  Future<List<Category>> fetchCategoriesList() async {
    try {
      Response response = await _dio.get(urls[2]);
      return categoryFromJson(jsonEncode(response.data));
    } catch (error, stacktrace) {
      return <Category>[];
    }
  }

  Future<List<Cart>> fetchCartsList() async {
    try {
      Response response = await _dio.get(urls[3]);
      return cartFromJson(jsonEncode(response.data));
    } catch (error, stacktrace) {
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
      return const User();
    }
  }

  Future<User> login(User user) async {
    try {
      var data = user.toJson();
      Response response = await _dio.post("${urls[0]}/login", data: data);
      return User.fromJson(response.data);
    } catch (e) {
      return const User();
    }
  }

  Future<bool> postProduct(Product product) async {
    try {
      var data = product.toJson();

      Response response = await _dio.post(
        urls[1],
        data: data,
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e, stacktrace) {
      return false;
    }
  }

  Future<String> saveImages(String fileName, File image) async {
    var fileExtension = image.path.split("/").last.split(".").last;
    var formData = FormData.fromMap({
      "image": MultipartFile.fromFileSync(
        image.path,
        filename: "$fileName.$fileExtension",
      ),
    });
    try {
      Response response = await _dio.post("${urls[1]}/save-image",
          data: formData,
          options: Options(headers: {
            "Content-Type": "multipart/form-data",
          }));
      return response.data;
    } catch (e) {
      return "";
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
      return const User();
    }
  }

  Future<bool> editProduct(Product product, int id) async {
    var data = product.toJson();
    try {
      Response response = await _dio.put("${urls[1]}/$id", data: data);
      return response.data;
    } catch (e, stacktrace) {
      return false;
    }
  }

  Future<Category> editCategory(Category category, int id) async {
    var data = FormData.fromMap({'data': jsonEncode(category.toJson())});

    try {
      Response response = await _dio.put("${urls[0]}/$id", data: data);
      return response.data;
    } catch (e, stacktrace) {
      return const Category();
    }
  }

  Future<Cart> editCart(Cart cart, int id) async {
    var data = FormData.fromMap({'data': jsonEncode(cart.toJson())});

    try {
      Response response = await _dio.put("${urls[0]}/$id", data: data);
      return response.data;
    } catch (e, stacktrace) {
      return Cart(id: "0", productId: "0", userId: "0", user: const User());
    }
  }

  //DELETE
  Future<int> deleteUser() async {
    try {
      Response response = await _dio.delete(urls[0]);
      return response.statusCode!;
    } catch (error, stacktrace) {
      return 400;
    }
  }

  Future<List<Product>> deleteProduct(int id) async {
    try {
      Response response = await _dio.delete("${urls[1]}/$id");

      return productsFromJson(jsonEncode(response.data));
    } catch (error, stacktrace) {
      return [];
    }
  }

  Future<int> deleteCategory() async {
    try {
      Response response = await _dio.get(urls[2]);
      return response.statusCode!;
    } catch (error, stacktrace) {
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
      return <Cart>[];
    }
  }
}
