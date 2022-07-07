import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.onClick,
  }) : super(key: key);
  final String title;
  final GestureTapCallback onClick;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: textColor,
            ),
          ),
          GestureDetector(
            onTap: onClick,
            child: const Text(
              "Quản lý",
              style: TextStyle(color: textColor),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              "Xem tất cả",
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
