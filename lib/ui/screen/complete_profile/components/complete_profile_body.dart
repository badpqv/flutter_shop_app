import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/screen/complete_profile/complete_profile_screen.dart';
import 'package:flutter_shop_app/ui/screen/complete_profile/components/complete_profile_form.dart';

class CompleteProfileBody extends StatelessWidget {
  const CompleteProfileBody({Key? key, required this.args}) : super(key: key);
  final CompleteProfileArguments args;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: SingleChildScrollView(
            child: Column(children: [
              const Text(
                "Hoàn thiện hồ sơ",
                style: headingStyle,
              ),
              const Text(
                "Complete your details or continue \nwith social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              CompleteProfileForm(
                args: args,
              ),
              const SizedBox(height: defaultPadding),
              const Text(
                "Việc đăng ký tài khoản sẽ đồng nghĩ với việc bạn đồng ý \nvới các Điều khoản sử dụng của Artery",
                textAlign: TextAlign.center,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
