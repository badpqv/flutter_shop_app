import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding,
      ),
      width: double.infinity,
      height: 90,
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(defaultBorderRadius * 2),
        ),
      ),
      child: const Text.rich(
        TextSpan(
            text: "Artery Gear: FUSION\n",
            style: TextStyle(
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: "Giảm giá 20%",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
      ),
    );
  }
}
