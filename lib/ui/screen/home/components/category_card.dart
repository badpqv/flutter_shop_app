import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
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
      padding:
          const EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 175,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
            child: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.fill,
                  width: 175,
                  height: 100,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.secondaryColor.withOpacity(0.5),
                        AppColors.primaryColor.withOpacity(0.1)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SizeConfig.defaultPadding,
                    vertical: SizeConfig.defaultPadding / 2,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: AppColors.primaryColor),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: const Offset(0, 6),
                                  blurRadius: 10,
                                  color:
                                      const Color(0xFFB0B0B0).withOpacity(0.2),
                                )
                              ]),
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
