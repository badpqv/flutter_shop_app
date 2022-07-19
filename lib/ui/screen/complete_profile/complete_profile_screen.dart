import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/screen/complete_profile/components/complete_profile_body.dart';
import 'package:flutter_shop_app/ui/screen/complete_profile/components/complete_profile_form.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);
  static String routeName = "/complete-profile";
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CompleteProfileArguments;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Đăng ký",
          style: TextStyle(
            color: AppColors.textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: CompleteProfileBody(
        args: args,
      ),
    );
  }
}

class CompleteProfileArguments {
  final String email;
  final String password;
  CompleteProfileArguments({required this.email, required this.password});
}
