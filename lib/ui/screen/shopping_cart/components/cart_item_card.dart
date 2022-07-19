import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/ui/screen/details/components/colors_dot.dart';
import 'package:flutter_shop_app/ui/screen/details/components/light_novel_type.dart';
import 'package:intl/intl.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffFAF9F6),
        borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: AspectRatio(
              aspectRatio: .9,
              child: Image.network(
                cart.product.images.split(",")[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 250,
                padding:
                    const EdgeInsets.only(right: SizeConfig.defaultPadding / 2),
                child: Text(
                  cart.product.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
              const SizedBox(
                height: SizeConfig.defaultPadding / 2,
              ),
              cart.product.categoryId == "4"
                  ? TypeSelectCard(
                      selectedType: cart.selectedColor,
                      product: cart.product,
                      index: cart.product.colors
                          .split(",")
                          .indexOf(cart.selectedColor),
                    )
                  : ColorDot(
                      color: Color(int.parse(cart.selectedColor)),
                      isSelected: false,
                    ),
              const SizedBox(
                height: SizeConfig.defaultPadding / 2,
              ),
              Text.rich(
                TextSpan(
                  text: NumberFormat.simpleCurrency(
                          locale: "vi", decimalDigits: 0)
                      .format(cart.product.price),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  children: [
                    TextSpan(
                      text: " x${cart.quantity}",
                      style: const TextStyle(color: AppColors.textColor),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
