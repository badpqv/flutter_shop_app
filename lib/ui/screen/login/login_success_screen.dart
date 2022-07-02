import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/components/custom_btn.dart';
import 'package:flutter_shop_app/ui/screen/home/home_screen.dart';

class LoginSuccessScreen extends StatelessWidget {
  const LoginSuccessScreen({Key? key}) : super(key: key);
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
      ),
      body: const Center(
        child: LoginSuccessBody(),
      ),
    );
  }
}

class LoginSuccessBody extends StatelessWidget {
  const LoginSuccessBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Image.asset(
          "assets/images/March7th_1.jpg",
          height: MediaQuery.of(context).size.height * 0.4,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        const Text.rich(
          TextSpan(
            text: "YAY! \n",
            style: TextStyle(
              color: primaryColor,
              fontSize: 30,
            ),
            children: [
              TextSpan(
                text: " Đăng nhập thành công",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: CustomButton(
            text: "Tới trang chủ",
            press: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
