import 'package:flutter/material.dart';

import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/home/home_screen.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/components/product_list_body.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);
  static String routeName = "/product-list";
  @override
  State<ProductListScreen> createState() => _ProductListState();
}

class _ProductListState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    final ProductListArguments args =
        ModalRoute.of(context)!.settings.arguments as ProductListArguments;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () async {
          await Navigator.pushNamed(context, HomeScreen.routeName,
              arguments: HomeArguments(user: args.user));
        }),
        title: const Text(
          "Quản lý sản phẩm",
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
      ),
      body: ProductListBody(
        category: args.category,
        user: args.user,
        callBack: args.callBack,
      ),
    );
  }
}

class ProductListArguments {
  final Category category;
  final User user;
  final Function callBack;
  ProductListArguments(
      {required this.category, required this.user, required this.callBack});
}
