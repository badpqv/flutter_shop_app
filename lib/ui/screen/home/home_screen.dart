import 'package:flutter/material.dart';
import 'package:flutter_shop_app/ui/components/custom_bottom_nav.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carts = fetchCarts();
    products = fetchProducts();
    categories = fetchCategories();
  }

  refreshState() {
    setState(() {
      carts = fetchCarts();
      products = fetchProducts();
      categories = fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final HomeArguments args =
        ModalRoute.of(context)!.settings.arguments as HomeArguments;

    return FutureBuilder(
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          var carts = (snapshot.data![0] as List<Cart>)
              .where((element) => element.user == args.user)
              .toList();
          var products = snapshot.data![2] as List<Product>;
          var categories = snapshot.data![1] as List<Category>;
          return SafeArea(
            child: Scaffold(
              appBar: HomeHeader(
                carts: carts,
                user: args.user,
                refreshStateCallback: refreshState,
              ),
              body: HomeScreenBody(
                categories: categories,
                products: products,
                user: args.user,
                refreshStateCallback: refreshState,
              ),
              bottomNavigationBar: CustomBottomAppBar(
                user: args.user,
              ),
            ),
          );
        }
        return SafeArea(
          child: Scaffold(
            appBar: HomeHeader(
              carts: const <Cart>[],
              refreshStateCallback: refreshState,
              user: args.user,
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
            bottomNavigationBar: CustomBottomAppBar(
              user: args.user,
            ),
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

class HomeArguments {
  final User user;
  const HomeArguments({required this.user});
}
