import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/screen/home/components/categories.dart';
import 'package:flutter_shop_app/ui/screen/home/components/discount_banner.dart';

import 'package:flutter_shop_app/ui/screen/home/components/home_header.dart';
import 'package:flutter_shop_app/ui/screen/home/components/popular.dart';
import 'package:flutter_shop_app/ui/screen/home/components/section_title.dart';
import 'package:flutter_shop_app/ui/screen/home/components/special_offer_card.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: defaultPadding,
            ),
            const HomeHeader(),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            const DiscountBanner(),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            const Categories(),
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
                    image: "assets/images/Image Banner.jpg",
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
            SectionTitle(title: "Popular", onClick: () {}),
            const PopularProducts(),
            const SizedBox(
              height: defaultPadding / 2,
            ),
          ],
        ),
      ),
    );
  }
}
