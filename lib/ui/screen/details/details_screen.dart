import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/details/components/details_screen_body.dart';
import 'package:flutter_shop_app/ui/screen/home/home_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  static String routeName = "/details";

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  setSelectedIndex(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(agrs.product.images.split(",")[selectedIndex]),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            primaryLightColor.withOpacity(0.4),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2,
          sigmaY: 2,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: AppBar(
              titleSpacing: 0,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: const SizedBox(
                height: (15),
                width: (15),
                child: BackButton(
                  color: Colors.white,
                ),
              ),
              actions: [
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
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
                            color: Colors.yellow,
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
            setSelectedIndex: setSelectedIndex,
          ),
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;
  final User user;
  ProductDetailsArguments({
    required this.product,
    required this.user,
  });
}
