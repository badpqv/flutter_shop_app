import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/components/add_product_body.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static String routeName = "/add-product";
  @override
  Widget build(BuildContext context) {
    final AddProductArguments args =
        ModalRoute.of(context)!.settings.arguments as AddProductArguments;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Thêm sản phẩm mới",
          style: TextStyle(
            color: primaryColor,
          ),
        ),
      ),
      body: AddProdductBody(
        user: args.user,
        category: args.category,
        callBack: args.callBack,
      ),
    );
  }
}

class AddProductArguments {
  final Category category;
  final User user;
  final Function callBack;
  const AddProductArguments(
      {required this.category, required this.user, required this.callBack});
}
