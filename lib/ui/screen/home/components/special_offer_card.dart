import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

class SpecialOffferCard extends StatelessWidget {
  const SpecialOffferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numberOfBrands,
    required this.onTap,
  }) : super(key: key);
  final String category, image;
  final int numberOfBrands;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 230,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            child: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.fill,
                  width: 230,
                  height: 100,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        primaryColor.withOpacity(0.5),
                        primaryColor.withOpacity(0.1)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                    vertical: defaultPadding / 2,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text:
                              "${numberOfBrands < 10 ? numberOfBrands.toString() : "10+"} sản phẩm",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
