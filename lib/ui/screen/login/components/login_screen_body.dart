import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/screen/login/components/login_form.dart';
import 'package:flutter_shop_app/ui/screen/login/components/social_card.dart';
import 'package:flutter_shop_app/ui/screen/register/register_screen.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultPadding * 2),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Welcome Back",
                  style: AppStyle.headingStyle,
                ),
                const Text(
                  "Đăng nhập bằng email và mật khẩu \nhoặc các tài khoản mạng xã hội",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: SizeConfig.defaultPadding * 2,
                ),
                const LoginForm(),
                const SizedBox(
                  height: SizeConfig.defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "hoặc tiếp tục với",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(
                  height: SizeConfig.defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: SizeConfig.defaultPadding),
                      child: SocialCard(
                        icon: const Icon(
                          Icons.facebook_outlined,
                          size: 25,
                          color: Colors.lightBlue,
                        ),
                        onClick: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: SizeConfig.defaultPadding),
                      child: SocialCard(
                        icon: const Icon(
                          FontAwesome.twitter,
                          size: 25,
                          color: Colors.lightBlue,
                        ),
                        onClick: () {},
                      ),
                    ),
                    SocialCard(
                      icon: const Icon(
                        FontAwesome.google,
                        size: 25,
                        color: Colors.redAccent,
                      ),
                      onClick: () {},
                    ),
                  ],
                ),
                const SizedBox(height: SizeConfig.defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Không có tài khoản?",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: const Text(
                        "Đăng ký",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
