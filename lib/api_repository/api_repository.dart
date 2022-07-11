import 'package:flutter_shop_app/api_providers/api_providers.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/nofification_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';

class ApiRepository {
  final _provider = ApiProvider();
  //FETCH
  Future<List<User>> fetchUsersList() {
    return _provider.fetchUsersList();
  }

  Future<List<Product>> fetchProductsList() {
    return _provider.fetchProductsList();
  }

  Future<List<Category>> fetchCategoriesList() {
    return _provider.fetchCategoriesList();
  }

  Future<List<Cart>> fetchCartsList() {
    return _provider.fetchCartsList();
  }

  Future<List<Cart>> fetchCurrentUserCart(User user) {
    return _provider.fetchCurrentUserCart(user);
  }

  Future<List<AppNotification>> fetchNotificationsList() {
    return _provider.fetchNotificationsList();
  }

  //POST
  Future<User> register(User user) {
    return _provider.register(user);
  }

  Future<User> login(User user) {
    return _provider.login(user);
  }

  Future<bool> postProduct(Product product) {
    return _provider.postProduct(product);
  }

  Future<bool> postCategory(Category category) {
    return _provider.postCategory(category);
  }

  Future<bool> postCart(Cart cart) {
    return _provider.postCart(cart);
  }

  Future<bool> sendNotification(AppNotification notification) {
    return _provider.sendNotification(notification);
  }

  //PUT
  Future<User> editUser(User user, int id) {
    return _provider.editUser(user, id);
  }

  Future<Product> editProduct(Product product, int id) {
    return _provider.editProduct(product, id);
  }

  Future<Category> editCategory(Category category, int id) {
    return _provider.editCategory(category, id);
  }

  Future<Cart> editCart(Cart cart, int id) {
    return _provider.editCart(cart, id);
  }

  //DELETE
  Future<List<Cart>> deleteCart(int id, User user) {
    return _provider.deleteCart(id, user);
  }
}

class NetworkError extends Error {}
