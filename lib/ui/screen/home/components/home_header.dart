import 'package:flutter/material.dart';

import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/home/components/icon_btn_with_counter.dart';
import 'package:flutter_shop_app/ui/screen/home/components/search_field.dart';
import 'package:flutter_shop_app/ui/screen/shopping_cart/cart_screen.dart';

class HomeHeader extends StatefulWidget implements PreferredSizeWidget {
  const HomeHeader({
    Key? key,
    required this.carts,
    required this.refreshStateCallback,
    required this.user,
  }) : super(key: key);
  final List<Cart> carts;
  final Function refreshStateCallback;
  final User user;
  @override
  State<HomeHeader> createState() => _HomeHeaderState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: [
          const SizedBox(
            height: defaultPadding / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SearchField(),
              Wrap(
                children: [
                  IconButtonWithCounter(
                    icon: Icons.shopping_cart_outlined,
                    numberOfItems: widget.carts.length,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        CartScreen.routeName,
                        arguments: CartArguments(
                          refreshSate: widget.refreshStateCallback,
                          user: widget.user,
                          carts: widget.carts,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  IconButtonWithCounter(
                    icon: Icons.notifications,
                    numberOfItems: 9,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: defaultPadding / 2,
          ),
        ],
      ),
    );
  }
}
