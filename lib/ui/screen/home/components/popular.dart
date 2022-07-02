import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/components/product_card.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'dart:convert';

import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/services/product_services.dart';
import 'package:flutter_shop_app/ui/screen/details/details_screen.dart';
import 'package:http/http.dart' as http;

class PopularProducts extends StatefulWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  late Future<List<Product>>? products;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      builder: (context, response) {
        if (response.hasError) {
          return Center(
            child: Text("${response.error} 😇"),
          );
        } else if (response.hasData) {
          var products = (response.data) as List<Product>;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  products.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2,
                    ),
                    child: ProductCard(
                      product: products[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments: ProductDetailsArguments(
                            product: products[index],
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
        return const CircularProgressIndicator(
          color: primaryColor,
        );
      },
      future: products,
    );
  }
}
