import 'package:flutter/material.dart';

import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/category_manage/components/category_list_body.dart';
import 'package:flutter_shop_app/ui/screen/home/home_screen.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/components/product_list_body.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({Key? key}) : super(key: key);
  static String routeName = "/category-list";
  @override
  State<CategoryListScreen> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    final CategoryListArguments args =
        ModalRoute.of(context)!.settings.arguments as CategoryListArguments;
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(
          context,
          HomeScreen.routeName,
          arguments: HomeArguments(user: args.user),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () async {
            await Navigator.pushNamed(context, HomeScreen.routeName,
                arguments: HomeArguments(user: args.user));
          }),
          title: const Text(
            "Quản lý danh mục",
            style: TextStyle(color: AppColors.primaryColor),
          ),
          centerTitle: true,
        ),
        body: CategoryListBody(
          categories: args.categories,
          user: args.user,
        ),
      ),
    );
  }
}

class CategoryListArguments {
  final List<Category> categories;
  final User user;

  CategoryListArguments({required this.categories, required this.user});
}
