import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/category_manage/components/edit_category_body.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/components/add_product_body.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/components/edit_product_body.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({Key? key}) : super(key: key);
  static String routeName = "/edit-category";
  @override
  Widget build(BuildContext context) {
    final EditCategoryArguments args =
        ModalRoute.of(context)!.settings.arguments as EditCategoryArguments;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Chỉnh sửa thông tin danh mục",
          style: TextStyle(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: EditCategoryBody(
        user: args.user,
        category: args.category,
      ),
    );
  }
}

class EditCategoryArguments {
  final Category category;
  final User user;

  const EditCategoryArguments({
    required this.category,
    required this.user,
  });
}
