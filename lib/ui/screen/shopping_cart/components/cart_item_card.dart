import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
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
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: .88,
              child: Image.asset(cart.product.images.split(",")[0]),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cart.product.title,
                style: const TextStyle(fontSize: 16, color: textColor),
                maxLines: 2,
              ),
              const SizedBox(
                height: defaultPadding / 2,
              ),
              Text.rich(
                TextSpan(
                  text: NumberFormat.simpleCurrency(
                          locale: "vi", decimalDigits: 0)
                      .format(cart.product.price),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                  children: [
                    TextSpan(
                      text: " x${cart.quantity}",
                      style: const TextStyle(color: textColor),
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
