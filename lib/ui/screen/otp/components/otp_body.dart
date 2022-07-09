import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/screen/otp/components/otp_form.dart';
import 'package:flutter_shop_app/ui/screen/otp/otp_screen.dart';

class OtpScreenBody extends StatelessWidget {
  const OtpScreenBody({Key? key, required this.args}) : super(key: key);
  final OtpArguments args;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: defaultPadding,
              ),
              const Text(
                "Xác nhận mã OTP",
                style: headingStyle,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              const Text(
                "Mã 0TP vừa được gửi đến số  +8484603****",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Hết hạn sau ",
                    style: TextStyle(fontSize: 16),
                  ),
                  TweenAnimationBuilder(
                    tween: Tween(
                        begin: const Duration(minutes: 3), end: Duration.zero),
                    duration: const Duration(minutes: 3),
                    builder: (BuildContext context, Duration value, child) =>
                        Text(
                      "${value.inMinutes}:${value.inSeconds % 60}",
                      style: const TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .15,
              ),
              OtpForm(
                arguments: args,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Gửi lại OTP",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
