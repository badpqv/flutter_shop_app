import 'package:flutter/material.dart';
import 'package:flutter_shop_app/ui/components/custom_btn.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/home/home_screen.dart';

class LoginSuccessBody extends StatelessWidget {
  const LoginSuccessBody({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(),
        width: MediaQuery.of(context).size.width * .9,
        height: MediaQuery.of(context).size.height * .9,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Image.asset(
              "assets/images/March7th_1.png",
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
                  Navigator.pushNamed(
                    context,
                    HomeScreen.routeName,
                    arguments: user,
                  );
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
