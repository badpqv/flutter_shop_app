import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/login/components/login_success_body.dart';

class LoginSuccessScreen extends StatelessWidget {
  const LoginSuccessScreen({Key? key}) : super(key: key);
  static String routeName = "/login_success";

  @override
  Widget build(BuildContext context) {
    final LoginSuccessArguments args =
        ModalRoute.of(context)!.settings.arguments as LoginSuccessArguments;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
      ),
      body: Center(
        child: LoginSuccessBody(
          user: args.user,
        ),
      ),
    );
  }
}

class LoginSuccessArguments {
  final User user;

  const LoginSuccessArguments({required this.user});
}
