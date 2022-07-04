import 'package:flutter/material.dart';
import 'package:flutter_shop_app/components/custom_bottom_nav.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/services/cart_services.dart';
import 'package:flutter_shop_app/services/category_services.dart';
import 'package:flutter_shop_app/services/product_services.dart';
import 'package:flutter_shop_app/ui/screen/home/components/home_body.dart';
import 'package:flutter_shop_app/ui/screen/home/components/home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Cart>> carts;
  late Future<List<Product>> products;
  late Future<List<Category>> categories;
  refreshState() {
    setState(() {
      carts = fetchCarts();
      products = fetchProducts();
      categories = fetchCategories();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carts = fetchCarts();
    products = fetchProducts();
    categories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          var carts = snapshot.data![0] as List<Cart>;
          var products = snapshot.data![2] as List<Product>;
          var categories = snapshot.data![1] as List<Category>;
          print(products[0].id);
          return SafeArea(
            child: Scaffold(
              appBar: HomeHeader(
                carts: carts,
                refreshStateCallback: refreshState,
              ),
              body: HomeScreenBody(
                categories: categories,
                products: products,
                refreshStateCallback: refreshState,
              ),
              bottomNavigationBar: const CustomBottomAppBar(),
            ),
          );
        }
        return SafeArea(
          child: Scaffold(
            appBar: HomeHeader(
              carts: const <Cart>[],
              refreshStateCallback: refreshState,
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
            bottomNavigationBar: const CustomBottomAppBar(),
          ),
        );
      },
      future: Future.wait(
        [
          carts,
          categories,
          products,
        ],
      ),
    );
  }
}
