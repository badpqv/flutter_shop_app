import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/ui/screen/home/components/categories.dart';
import 'package:flutter_shop_app/ui/screen/home/components/discount_banner.dart';
import 'package:flutter_shop_app/ui/screen/home/components/figure.dart';
import 'package:flutter_shop_app/ui/screen/home/components/section_title.dart';
import 'package:flutter_shop_app/ui/screen/home/components/special_offer_card.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({
    Key? key,
    required this.products,
    required this.categories,
    required this.refreshStateCallback,
  }) : super(key: key);
  final List<Product> products;
  final List<Category> categories;
  final Function refreshStateCallback;
  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: defaultPadding / 2,
            ),
            const DiscountBanner(),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            Categories(categories: widget.categories),
            const SizedBox(
              height: defaultPadding,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: SectionTitle(
                title: "Special for you",
                onClick: () {},
              ),
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpecialOffferCard(
                    image: "assets/images/Image Banner.png",
                    category: "Gaming  Gear",
                    numberOfBrands: 10,
                    onTap: () {},
                  ),
                  SpecialOffferCard(
                    image: "assets/images/Image Banner 2.png",
                    category: "Smartphone",
                    numberOfBrands: 5,
                    onTap: () {},
                  ),
                  SpecialOffferCard(
                    image: "assets/images/Figure.png",
                    category: "Figure",
                    numberOfBrands: 20,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            SectionTitle(title: "Genshin Impact", onClick: () {}),
            FigureProducts(
              products: widget.products,
              refreshState: widget.refreshStateCallback,
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
          ],
        ),
      ),
    );
  }
}
