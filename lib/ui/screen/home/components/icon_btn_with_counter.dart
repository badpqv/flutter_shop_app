import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

class IconButtonWithCounter extends StatelessWidget {
  const IconButtonWithCounter({
    Key? key,
    required this.icon,
    required this.numberOfItems,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final int numberOfItems;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(defaultBorderRadius * 5),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.5,
                  color: Colors.white,
                ),
              ),
              child: Center(
                child: Text(
                  numberOfItems < 9 ? numberOfItems.toString() : "9+",
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1,
                    color: primaryLightColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
