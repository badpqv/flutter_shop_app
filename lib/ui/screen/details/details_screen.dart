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
    final ProductDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeScreen.routeName,
            arguments: HomeArguments(
              user: args.user,
            ));

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryLightColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: AppBar(
              titleSpacing: 0,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.all(SizeConfig.defaultPadding / 3),
                child: SizedBox(
                  height: (10),
                  width: (10),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: AppColors.primaryColor,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () => Navigator.popAndPushNamed(
                      context,
                      HomeScreen.routeName,
                      arguments: HomeArguments(user: args.user),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.primaryColor,
                    ),
                  ),
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
                            "${args.product.rating}",
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
            product: args.product,
            user: args.user,
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
