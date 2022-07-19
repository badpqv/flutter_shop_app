import 'package:flutter/material.dart';

import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/home/components/icon_btn_with_counter.dart';
import 'package:flutter_shop_app/ui/screen/home/components/search_field.dart';
import 'package:flutter_shop_app/ui/screen/home/home_screen.dart';
import 'package:flutter_shop_app/ui/screen/shopping_cart/cart_screen.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class HomeHeader extends StatefulWidget implements PreferredSizeWidget {
  const HomeHeader({
    Key? key,
    required this.carts,
    required this.user,
  }) : super(key: key);
  final List<Cart> carts;
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
      padding:
          const EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding),
      child: Column(
        children: [
          const SizedBox(
            height: SizeConfig.defaultPadding / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SearchField(),
              Wrap(
                children: [
                  IconButtonWithCounter(
                    icon: FontAwesome5.truck,
                    numberOfItems: 0,
                    onTap: () {},
                  ),
                  const SizedBox(
                    width: SizeConfig.defaultPadding / 2,
                  ),
                  IconButtonWithCounter(
                    icon: Icons.shopping_cart_outlined,
                    numberOfItems: widget.carts.length,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        CartScreen.routeName,
                        arguments: CartArguments(
                          user: widget.user,
                          previousRouteName: HomeScreen.routeName,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: SizeConfig.defaultPadding / 2,
                  ),
                  IconButtonWithCounter(
                    icon: Icons.notifications_active_outlined,
                    numberOfItems: 9,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: SizeConfig.defaultPadding / 2,
          ),
        ],
      ),
    );
  }
}
