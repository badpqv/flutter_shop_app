import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/ui/screen/all_products/components/all_products_body.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);
  static String routeName = "/all_products";
  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    final ProductsArguments args =
        ModalRoute.of(context)!.settings.arguments as ProductsArguments;
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text(
            "Tất cả sản phẩm",
            style: TextStyle(
              color: primaryColor,
            ),
          ),
        ),
        body: AllProductBody(args: args));
  }
}

class ProductsArguments {
  final List<Product> products;
  final List<Category> categories;
  const ProductsArguments({required this.products, required this.categories});
}
