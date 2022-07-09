import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/ui/components/product_card.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'dart:convert';

import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/details/details_screen.dart';
import 'package:http/http.dart' as http;

class CharacterCards extends StatefulWidget {
  const CharacterCards({
    Key? key,
    required this.products,
    required this.user,
  }) : super(key: key);
  final List<Product> products;
  final User user;
  @override
  State<CharacterCards> createState() => _CharacterCardsState();
}

class _CharacterCardsState extends State<CharacterCards> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var filterList = widget.products.toList()
      ..sort((a, b) => a.title.compareTo(b.title));
    // TODO: i    mplement build
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
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
                          product: filterList[index],
                          user: widget.user,
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
