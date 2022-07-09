import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/bloc/cart/cart_bloc.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/components/cart_bottom_nav.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/ui/screen/details/details_screen.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CartBloc(user: args.user)
            ..add(
              GetCartList(),
            ),
        ),
      ],
      child: BlocListener<CartBloc, CartState>(
        listener: (context, state) {},
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
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
                    state is CartLoaded
                        ? Text(
                            "${state.carts.length} sản phẩm",
                            style: Theme.of(context).textTheme.caption,
                          )
                        : Text(
                            "0 sản phẩm",
                            style: Theme.of(context).textTheme.caption,
                          ),
                  ],
                ),
              ),
              body: state is CartLoaded
                  ? buildCartBody(state, state.carts)
                  : buildCartBody(state, <Cart>[]),
              bottomNavigationBar: state is CartLoaded
                  ? CartBottomNavbar(carts: state.carts)
                  : const CartBottomNavbar(carts: <Cart>[]),
            );
          },
        ),
      ),
    );
  }

  Padding buildCartBody(CartState state, List<Cart> carts) {
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
                context.read<CartBloc>().add(
                      DeleteCart(
                        cart: carts[index],
                      ),
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
  final User user;
  final String previousRouteName;
  CartArguments({
    required this.user,
    required this.previousRouteName,
  });
}
