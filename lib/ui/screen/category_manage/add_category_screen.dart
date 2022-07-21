import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/category_manage/components/add_category_body.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/components/add_product_body.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);
  static String routeName = "/add-category";
  @override
  Widget build(BuildContext context) {
    final AddCategoryArguments args =
        ModalRoute.of(context)!.settings.arguments as AddCategoryArguments;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Thêm danh mục mới",
          style: TextStyle(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: AddCategoryBody(
        user: args.user,
      ),
    );
  }
}

class AddCategoryArguments {
  final User user;

  const AddCategoryArguments({required this.user});
}
