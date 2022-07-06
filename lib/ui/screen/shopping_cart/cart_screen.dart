import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/components/cart_bottom_nav.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/services/cart_services.dart';
import 'package:flutter_shop_app/ui/screen/home/home_screen.dart';
import 'package:flutter_shop_app/ui/screen/shopping_cart/components/cart_item_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CartArguments args =
        ModalRoute.of(context)!.settings.arguments as CartArguments;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Giỏ hàng",
              style: TextStyle(
                color: primaryColor,
              ),
            ),
            Text(
              "${args.carts.length} sản phẩm",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
      body: buildCartBody(),
      bottomNavigationBar: CartBottomNavbar(carts: args.carts),
    );
  }

  Padding buildCartBody() {
    final CartArguments args =
        ModalRoute.of(context)!.settings.arguments as CartArguments;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 4),
      child: ListView.builder(
        itemCount: args.carts.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
          child: Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(UniqueKey().toString()),
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(defaultBorderRadius * 1.5),
              ),
              child: Row(children: [
                const Spacer(),
                Icon(
                  FontAwesomeIcons.solidTrashCan,
                  color: Colors.redAccent[200],
                ),
              ]),
            ),
            onDismissed: (direction) async {
              setState(() {
                deleteCart(int.parse(args.carts[index].id)).then((value) {
                  args.refreshSate();
                });
                args.carts.removeAt(index);
              });
            },
            child: CartItemCard(
              cart: args.carts[index],
            ),
          ),
        ),
      ),
    );
  }
}

class CartArguments {
  final Function refreshSate;
  final User user;
  final List<Cart> carts;
  CartArguments({
    required this.user,
    required this.refreshSate,
    required this.carts,
  });
}
