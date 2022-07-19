import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/screen/forgot_password/components/forgot_pass_body.dart';
import 'package:flutter_shop_app/ui/screen/forgot_password/components/forgot_pass_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static String routeName = "/forgot-password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Quên mật khẩu",
          style: TextStyle(
            color: AppColors.textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: const ForgotPasswordBody(),
    );
  }
}
