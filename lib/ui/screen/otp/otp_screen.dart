import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/login/components/otp_body.dart';
import 'package:flutter_shop_app/ui/screen/otp/components/otp_form.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final args = ModalRoute.of(context)!.settings.arguments as OtpArguments;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "OTP Verification",
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
      ),
      body: OtpScreenBody(
        args: args,
      ),
    );
  }
}

class OtpArguments {
  final User user;
  const OtpArguments({required this.user});
}
