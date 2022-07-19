import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/components/add_product_body.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/components/edit_product_body.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static String routeName = "/edit-product";
  @override
  Widget build(BuildContext context) {
    final EditProductArguments args =
        ModalRoute.of(context)!.settings.arguments as EditProductArguments;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Chỉnh sửa thông tin sản phẩm",
          style: TextStyle(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: EditProdductBody(
        user: args.user,
        category: args.category,
        product: args.product,
      ),
    );
  }
}

class EditProductArguments {
  final Category category;
  final Product product;
  final User user;

  const EditProductArguments({
    required this.product,
    required this.category,
    required this.user,
  });
}
