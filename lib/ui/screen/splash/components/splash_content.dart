import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

class SplashContent extends StatelessWidget {
  final String? text;
  final String? image;
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "ARTERY GEAR",
          style: TextStyle(
            fontSize: 40,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const Spacer(
          flex: 2,
        ),
        Image.asset(
          image!,
          height: MediaQuery.of(context).size.height * .35,
          width: MediaQuery.of(context).size.height * .35,
        ),
      ],
    );
  }
}
