import 'package:flutter/material.dart';
import 'package:flutter_shop_app/components/custom_btn.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/services/cart_services.dart';
import 'package:flutter_shop_app/ui/screen/details/components/colors_dot.dart';
import 'package:flutter_shop_app/ui/screen/details/components/product_description.dart';
import 'package:flutter_shop_app/ui/screen/details/components/product_images.dart';
import 'package:flutter_shop_app/ui/screen/details/components/top_rounded_corner.dart';
import 'package:flutter_shop_app/ui/screen/shopping_cart/cart_screen.dart';

class DetailsScreenBody extends StatefulWidget {
  final Product product;
  const DetailsScreenBody({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailsScreenBody> createState() => _DetailsScreenBodyState();
}

class _DetailsScreenBodyState extends State<DetailsScreenBody> {
  Future<List<Cart>>? futureCarts;
  int imageIndex = 0;
  int colorIndex = 0;
  int prodQuantity = 1;
  var initialQuantity = 0;

  getImageIndex(index) {
    setState(() {
      imageIndex = index;
    });
  }

  getColorIndex(index) {
    setState(() {
      colorIndex = index;
    });
  }

  getQuantity(quantity) {
    setState(() {
      prodQuantity = quantity;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCarts = fetchCarts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var carts = snapshot.data as List<Cart>;
          return ListView(
            children: [
              ProductImages(
                product: widget.product,
                callback: getImageIndex,
              ),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    ProductDescription(
                      product: widget.product,
                      onTap: () {},
                    ),
                    TopRoundedContainer(
                      color: const Color(0xFFF6F7F9),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding,
                          vertical: defaultPadding / 5,
                        ),
                        child: Column(
                          children: [
                            ColorDots(
                              product: widget.product,
                              callback: getColorIndex,
                              quantityGetter: getQuantity,
                            ),
                            TopRoundedContainer(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * .15,
                                  right:
                                      MediaQuery.of(context).size.width * .15,
                                  bottom: 21,
                                ),
                                child: CustomButton(
                                  text: "Thêm vào giỏ hàng",
                                  press: () {
                                    var hasProduct = carts
                                        .where((x) =>
                                            x.product.id == widget.product.id)
                                        .toList();
                                    var isExisted = hasProduct.isNotEmpty;
                                    setState(() {
                                      postCart(
                                        Cart(
                                          id: isExisted
                                              ? hasProduct[0].id
                                              : "0",
                                          product: widget.product,
                                          quantity: isExisted
                                              ? hasProduct[0].quantity
                                              : prodQuantity,
                                        ),
                                        prodQuantity,
                                        isExisted,
                                      );
                                    });

                                    final snackBar = SnackBar(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: defaultPadding / 2,
                                        vertical: defaultPadding / 2,
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      content: const Text(
                                          'Đã thêm sản phẩm vào giỏ hàng'),
                                      shape: const StadiumBorder(),
                                      backgroundColor: primaryColor,
                                      dismissDirection:
                                          DismissDirection.startToEnd,
                                      duration: const Duration(
                                          seconds: 1, milliseconds: 200),
                                      action: SnackBarAction(
                                        label: 'Xem giỏ hàng',
                                        textColor: Colors.white70,
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, CartScreen.routeName);
                                          setState(() {
                                            futureCarts = fetchCarts();
                                          });
                                        },
                                      ),
                                    );

                                    // Find the ScaffoldMessenger in the widget tree
                                    // and use it to show a SnackBar.
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      future: futureCarts,
    );
  }
}
