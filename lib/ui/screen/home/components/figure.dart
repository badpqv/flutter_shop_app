import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/components/product_card.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'dart:convert';

import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/services/product_services.dart';
import 'package:flutter_shop_app/ui/screen/details/details_screen.dart';
import 'package:http/http.dart' as http;

class FigureProducts extends StatefulWidget {
  const FigureProducts({
    Key? key,
    required this.products,
    required this.refreshState,
  }) : super(key: key);
  final Function refreshState;
  final List<Product> products;
  @override
  State<FigureProducts> createState() => _FigureProductsState();
}

class _FigureProductsState extends State<FigureProducts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var filterList = widget.products.toList();
    // TODO: i    mplement build
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            filterList.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2,
              ),
              child: filterList.isEmpty
                  ? const Center(
                      child: Text("Không có sản phẩm nào"),
                    )
                  : ProductCard(
                      product: filterList[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments: ProductDetailsArguments(
                            refreshState: widget.refreshState,
                            product: filterList[index],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
