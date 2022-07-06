import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/details/components/details_screen_body.dart';
import 'package:flutter_shop_app/ui/screen/home/home_screen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  static String routeName = "/details";
  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: AppBar(
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const SizedBox(
            height: (15),
            width: (15),
            child: BackButton(),
          ),
          actions: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${agrs.product.rating}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.star,
                        color: Colors.yellowAccent,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: DetailsScreenBody(
        product: agrs.product,
        user: agrs.user,
        refreshState: agrs.refreshState,
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;
  final Function refreshState;
  final User user;
  ProductDetailsArguments({
    required this.refreshState,
    required this.product,
    required this.user,
  });
}
