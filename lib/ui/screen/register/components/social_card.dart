import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    Key? key,
    required this.icon,
    required this.onClick,
  }) : super(key: key);
  final Icon icon;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        alignment: Alignment.center,
        height: SizeConfig.defaultPadding * 2.5,
        width: SizeConfig.defaultPadding * 2.5,
        decoration: const BoxDecoration(
          color: Color(0xfff5f6f9),
          shape: BoxShape.circle,
        ),
        child: icon,
      ),
    );
  }
}
