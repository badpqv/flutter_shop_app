import 'package:flutter/material.dart';
import 'package:flutter_shop_app/components/cart_bottom_nav.dart';
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
  Future<List<Cart>>? futureCarts;
  List<Cart> carts = <Cart>[];
  Future<Cart>? cart;
  int? cartsLength;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCarts = fetchCarts();
    cart = fetchCart("1");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("${snapshot.error}"),
          );
        } else if (snapshot.hasData) {
          carts = snapshot.data as List<Cart>;
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
                    "${carts.length} sản phẩm",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            body: buildCartBody(),
            bottomNavigationBar: CartBottomNavbar(carts: carts),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        );
      },
      future: futureCarts,
    );
  }

  Padding buildCartBody() {
    final CartArguments args =
        ModalRoute.of(context)!.settings.arguments as CartArguments;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 4),
      child: ListView.builder(
        itemCount: carts.length,
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
                cart = deleteCart(carts[index].id).whenComplete(
                  () => args.refreshSate(),
                );
                carts.removeAt(index);
              });
            },
            child: CartItemCard(
              cart: carts[index],
            ),
          ),
        ),
      ),
    );
  }
}

class CartArguments {
  final Function refreshSate;
  CartArguments({
    required this.refreshSate,
  });
}
