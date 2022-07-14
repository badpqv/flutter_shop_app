import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/bloc/cart/cart_bloc.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/components/custom_bottom_nav.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/home/components/home_body.dart';
import 'package:flutter_shop_app/ui/screen/home/components/home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeArguments args =
        ModalRoute.of(context)!.settings.arguments as HomeArguments;
    return BlocProvider(
      create: (context) => CartBloc(user: args.user)..add(GetCartList()),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return SafeArea(
            child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Scaffold(
                appBar: state is CartLoaded
                    ? HomeHeader(
                        carts: state.carts,
                        user: args.user,
                      )
                    : HomeHeader(
                        carts: const <Cart>[],
                        user: args.user,
                      ),
                body: HomeScreenBody(
                  user: args.user,
                ),
                bottomNavigationBar: CustomBottomAppBar(
                  user: args.user,
                  selectedMenu: Menu.home,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomeArguments {
  final User user;
  const HomeArguments({required this.user});
}
