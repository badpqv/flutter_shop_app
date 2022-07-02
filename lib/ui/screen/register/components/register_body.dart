import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/screen/register/components/register_form.dart';
import 'package:flutter_shop_app/ui/screen/register/components/social_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Đăng ký tài khoản",
              textAlign: TextAlign.center,
              style: headingStyle,
            ),
            const Text(
              "Complete your details or continue \nwith social media",
              textAlign: TextAlign.center,
            ),
            const RegisterForm(),
            const SizedBox(
              height: defaultPadding,
            ),
            Center(
              child: Column(
                children: [
                  const Text(
                    "hoặc đăng nhập bằng",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: defaultPadding),
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
                        padding: const EdgeInsets.only(right: defaultPadding),
                        child: SocialCard(
                          icon: const Icon(
                            FontAwesomeIcons.twitter,
                            size: 25,
                            color: Colors.lightBlue,
                          ),
                          onClick: () {},
                        ),
                      ),
                      SocialCard(
                        icon: const Icon(
                          FontAwesomeIcons.google,
                          size: 25,
                          color: Colors.redAccent,
                        ),
                        onClick: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  const Text(
                    "Việc đăng ký tài khoản sẽ đồng nghĩ với việc bạn đồng ý \nvới các Điều khoản sử dụng của Artery",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
