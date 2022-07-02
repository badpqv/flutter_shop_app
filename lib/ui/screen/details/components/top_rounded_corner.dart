import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);
  final Color color;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      padding: const EdgeInsets.only(top: defaultPadding),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(defaultBorderRadius * 4),
          topRight: Radius.circular(defaultBorderRadius * 4),
        ),
      ),
      child: child,
    );
  }
}
