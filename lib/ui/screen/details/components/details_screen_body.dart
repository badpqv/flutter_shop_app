import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/bloc/cart/cart_bloc.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/components/custom_btn.dart';
import 'package:flutter_shop_app/ui/screen/details/components/colors_dot.dart';
import 'package:flutter_shop_app/ui/screen/details/components/light_novel_type.dart';
import 'package:flutter_shop_app/ui/screen/details/components/product_description.dart';
import 'package:flutter_shop_app/ui/screen/details/components/product_images.dart';
import 'package:flutter_shop_app/ui/screen/details/components/top_rounded_corner.dart';
import 'package:flutter_shop_app/ui/screen/details/details_screen.dart';
import 'package:flutter_shop_app/ui/screen/shopping_cart/cart_screen.dart';

class DetailsScreenBody extends StatefulWidget {
  final Product product;
  final User user;
  final Function setSelectedIndex;
  const DetailsScreenBody({
    Key? key,
    required this.product,
    required this.user,
    required this.setSelectedIndex,
  }) : super(key: key);

  @override
  State<DetailsScreenBody> createState() => _DetailsScreenBodyState();
}

class _DetailsScreenBodyState extends State<DetailsScreenBody> {
  int imageIndex = 0;
  int colorIndex = 0;
  int prodQuantity = 1;

  String LNType = "";
  setImageIndex(index) {
    setState(() {
      imageIndex = index;
    });
  }

  setColorIndex(index) {
    setState(() {
      colorIndex = index;
    });
  }

  setQuantity(quantity) {
    setState(() {
      prodQuantity = quantity;
    });
  }

  setLNType(LNType) {
    setState(() {
      this.LNType = LNType;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartBloc(user: widget.user)..add(GetCartList()),
        ),
      ],
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.product.images.split(",")[imageIndex],
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryLightColor.withOpacity(0.4),
                    BlendMode.dstATop,
                  ),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Column(
                  children: [
                    ProductImages(
                      product: widget.product,
                      callbacks: [setImageIndex, widget.setSelectedIndex],
                    ),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ProductDescription(
                            product: widget.product,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(widget.product.title),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        Text(widget.product.description),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          TopRoundedContainer(
                            color: const Color(0xFFF6F7F9),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: SizeConfig.defaultPadding,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    widget.product.categoryId == "4"
                                        ? LightNovelType(
                                            product: widget.product,
                                            onTypeSelect: setLNType,
                                            quantityGetter: setQuantity,
                                          )
                                        : ColorDots(
                                            product: widget.product,
                                            callback: setColorIndex,
                                            quantityGetter: setQuantity,
                                          ),
                                    TopRoundedContainer(
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .15,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .15,
                                          bottom: SizeConfig.defaultPadding * 2,
                                        ),
                                        child: CustomButton(
                                          text: "Thêm vào giỏ hàng",
                                          press: () {
                                            if (state is CartLoaded) {
                                              var selectedColor = widget
                                                          .product.categoryId !=
                                                      "4"
                                                  ? widget.product.colors
                                                      .split(",")[colorIndex]
                                                  : LNType;
                                              var existProduct =
                                                  state.carts.firstWhere(
                                                (x) =>
                                                    x.product.id ==
                                                        widget.product.id &&
                                                    x.selectedColor ==
                                                        selectedColor &&
                                                    x.user.id == widget.user.id,
                                                orElse: () => Cart(
                                                  productId: "",
                                                  userId: "",
                                                  user: const User(),
                                                ),
                                              );
                                              var isExisted = existProduct !=
                                                  Cart(
                                                    productId: "",
                                                    userId: "",
                                                    user: const User(),
                                                  );
                                              setState(
                                                () {
                                                  context.read<CartBloc>().add(
                                                        AddCart(
                                                          cart: Cart(
                                                            id: isExisted
                                                                ? existProduct
                                                                    .id
                                                                : "0",
                                                            product:
                                                                widget.product,
                                                            quantity: isExisted
                                                                ? prodQuantity +
                                                                    existProduct
                                                                        .quantity
                                                                : prodQuantity,
                                                            productId: widget
                                                                .product.id,
                                                            userId:
                                                                widget.user.id,
                                                            selectedColor: widget
                                                                        .product
                                                                        .categoryId ==
                                                                    "4"
                                                                ? LNType
                                                                : selectedColor,
                                                            user: widget.user,
                                                          ),
                                                        ),
                                                      );
                                                  var snackBar =
                                                      addToCartSnackbar(
                                                          context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SnackBar addToCartSnackbar(BuildContext context) {
    return SnackBar(
      padding: const EdgeInsets.symmetric(
        horizontal: SizeConfig.defaultPadding / 2,
        vertical: SizeConfig.defaultPadding / 2,
      ),
      behavior: SnackBarBehavior.floating,
      content: const Text('Đã thêm sản phẩm vào giỏ hàng'),
      shape: const StadiumBorder(),
      backgroundColor: AppColors.primaryColor,
      dismissDirection: DismissDirection.endToStart,
      duration: const Duration(seconds: 1, milliseconds: 200),
      action: SnackBarAction(
        label: 'Xem giỏ hàng',
        textColor: Colors.white70,
        onPressed: () {
          Navigator.pushNamed(
            context,
            CartScreen.routeName,
            arguments: CartArguments(
              user: widget.user,
              previousRouteName: DetailsScreen.routeName,
            ),
          );
        },
      ),
    );
  }
}
