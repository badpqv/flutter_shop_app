import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/screen/forgot_password/components/forgot_pass_form.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SizeConfig.defaultPadding,
          ),
          child: SingleChildScrollView(
            child: Column(children: const [
              Text(
                "Quên mật khẩu",
                style: AppStyle.headingStyle,
              ),
              Text(
                "Nhập email của bạn và chúng tôi sẽ gửi \nlink để khổi phục tài khoản của bạn",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 15,
                ),
              ),
              ForgotPasswordForm(),
            ]),
          ),
        ),
      ),
    );
  }
}
