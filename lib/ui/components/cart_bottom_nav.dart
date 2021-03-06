import 'package:flutter/material.dart';
import 'package:flutter_shop_app/ui/components/custom_btn.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:intl/intl.dart';

class CartBottomNavbar extends StatelessWidget {
  const CartBottomNavbar({
    Key? key,
    required this.carts,
  }) : super(key: key);

  final List<Cart> carts;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: SizeConfig.defaultPadding * .75,
        horizontal: SizeConfig.defaultPadding * 1.5,
      ),
      height: 175,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(SizeConfig.defaultBorderRadius * 3),
          topRight: Radius.circular(SizeConfig.defaultBorderRadius * 3),
        ),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDADADA).withOpacity(.15)),
        ],
      ),
      child: SafeArea(
        child: Column(children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(SizeConfig.defaultPadding / 2),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius:
                      BorderRadius.circular(SizeConfig.defaultBorderRadius),
                ),
                child: const Center(
                  child: Icon(
                    Icons.receipt_long_outlined,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                ),
              ),
              const Spacer(),
              const Text("Thêm mã khuyến mãi"),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.arrow_forward,
                color: AppColors.primaryColor,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: "Thành tiền: \n",
                  style: const TextStyle(
                    color: AppColors.textColor,
                  ),
                  children: [
                    TextSpan(
                      text: NumberFormat.simpleCurrency(
                        locale: "vi",
                        decimalDigits: 0,
                      ).format(
                        carts.fold<double>(
                          0,
                          (previousValue, element) => (previousValue +
                              element.product.price * element.quantity),
                        ),
                      ),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 200,
                child: CustomButton(
                  text: "🧾 Thanh toán",
                  press: () {},
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
