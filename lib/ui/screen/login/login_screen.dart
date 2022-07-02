import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

import 'package:flutter_shop_app/ui/screen/login/components/login_screen_body.dart';

class LoginPage extends StatelessWidget {
  static String routeName = "/login";

  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Đăng nhập",
          style: TextStyle(color: textColor),
        ),
      ),
      body: const LoginPageBody(),
    );
  }
}
