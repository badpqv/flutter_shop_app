import 'package:flutter/material.dart';

import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/services/cart_services.dart';
import 'package:flutter_shop_app/ui/screen/home/components/icon_btn_with_counter.dart';
import 'package:flutter_shop_app/ui/screen/home/components/search_field.dart';
import 'package:flutter_shop_app/ui/screen/shopping_cart/cart_screen.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  Future<int>? cartsLength;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartsLength = getCartsLength();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          int cartlength = snapshot.data as int;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SearchField(),
                IconButtonWithCounter(
                  icon: Icons.shopping_cart_outlined,
                  numberOfItems: cartlength,
                  onTap: () {
                    Navigator.pushNamed(context, CartScreen.routeName)
                        .whenComplete(() {
                      setState(() {
                        cartsLength = getCartsLength();
                      });
                    });
                  },
                ),
                IconButtonWithCounter(
                  icon: Icons.notifications,
                  numberOfItems: 9,
                  onTap: () {},
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
      future: cartsLength,
    );
  }
}
