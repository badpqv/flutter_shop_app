import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/bloc/category/category_bloc.dart';
import 'package:flutter_shop_app/bloc/product/product_bloc.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/home/components/categories.dart';
import 'package:flutter_shop_app/ui/screen/home/components/discount_banner.dart';
import 'package:flutter_shop_app/ui/screen/home/components/character_cards.dart';
import 'package:flutter_shop_app/ui/screen/home/components/section_title.dart';
import 'package:flutter_shop_app/ui/screen/home/components/special_offer_card.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;
  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (_) => CategoryBloc()..add(GetCategoriesList()),
        ),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc()..add(GetProductsList()),
        ),
      ],
      child: SafeArea(
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
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return state is CategoryLoaded
                      ? Categories(categories: state.categories)
                      : const Categories(categories: <Category>[]);
                },
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: SectionTitle(
                  hasPermission: false,
                  title: "Special for you",
                  onClick: () {},
                ),
              ),
              const SizedBox(
                height: defaultPadding / 2,
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return Column(
                    children: [
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
                              category: "Cards",
                              numberOfBrands: state is ProductLoaded
                                  ? state.products.length
                                  : 0,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding / 2,
                      ),
                      SectionTitle(
                          title: "Populars",
                          hasPermission: widget.user.isVerified,
                          onClick: () {}),
                      CharacterCards(
                        products: state is ProductLoaded
                            ? state.products
                                .where((element) => element.isPopular)
                                .toList()
                            : <Product>[],
                        user: widget.user,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: defaultPadding / 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
