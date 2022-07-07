import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/components/product_card.dart';
import 'package:flutter_shop_app/ui/screen/all_products/all_products_screen.dart';
import 'package:flutter_shop_app/ui/screen/all_products/components/add_products.dart';

class AllProductBody extends StatelessWidget {
  const AllProductBody({
    Key? key,
    required this.args,
  }) : super(key: key);

  final ProductsArguments args;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
              args.categories.length,
              (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              args.categories[index].title,
                              style: const TextStyle(
                                fontSize: 18,
                                color: textColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AddProductScreen.routeName,
                                );
                              },
                              child: const Text(
                                "Thêm sản phẩm",
                                style: TextStyle(
                                  color: textColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(
                                  args.products
                                      .where((element) =>
                                          element.categoryId ==
                                          args.categories[index].id)
                                      .length,
                                  (prodIndex) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: defaultPadding,
                                      ),
                                      child: ProductCard(
                                        product: args.products
                                            .where((element) =>
                                                element.categoryId ==
                                                args.categories[index].id)
                                            .toList()[prodIndex],
                                        onTap: () {},
                                      )))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
        ],
      ),
    );
  }
}
