import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/bloc/category/category_bloc.dart';
import 'package:flutter_shop_app/bloc/product/product_bloc.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/home/components/categories.dart';
import 'package:flutter_shop_app/ui/screen/home/components/discount_banner.dart';
import 'package:flutter_shop_app/ui/screen/home/components/character_cards.dart';
import 'package:flutter_shop_app/ui/screen/home/components/section_title.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/product_list.dart';

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
  late CategoryBloc loadCategories;
  late ProductBloc loadProducts;
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double scaleFactor = 0.8;
  int currentPage = 0;
  double height = 220;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
    loadCategories = CategoryBloc()..add(GetCategoriesList());
    loadProducts = ProductBloc()..add(GetProductsList());
  }

  refreshBlocState() {
    setState(() {
      loadCategories = CategoryBloc()..add(GetCategoriesList());
      loadProducts = ProductBloc()..add(GetProductsList());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (_) => loadCategories,
        ),
        BlocProvider<ProductBloc>(
          create: (_) => loadProducts,
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: SizeConfig.defaultPadding / 2,
            ),
            const DiscountBanner(),
            const SizedBox(
              height: SizeConfig.defaultPadding / 2,
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                return Column(
                  children: [
                    const SizedBox(
                      height: SizeConfig.defaultPadding / 2,
                    ),
                    state is ProductLoaded
                        ? Column(
                            children: [
                              const SizedBox(
                                height: SizeConfig.defaultPadding / 2,
                              ),
                              const SizedBox(
                                height: SizeConfig.defaultPadding / 2,
                              ),
                              BlocBuilder<CategoryBloc, CategoryState>(
                                builder: (context, state) {
                                  return state is CategoryLoaded
                                      ? Categories(
                                          categories: state.categories
                                            ..sort(
                                              (a, b) =>
                                                  a.title.compareTo(b.title),
                                            ),
                                        )
                                      : const Categories(
                                          categories: <Category>[]);
                                },
                              ),
                              const SizedBox(
                                height: SizeConfig.defaultPadding,
                              ),
                              ...List.generate(
                                (state.categories
                                      ..sort(
                                        (a, b) => a.title.compareTo(b.title),
                                      ))
                                    .length,
                                (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: SizeConfig.defaultPadding / 2,
                                  ),
                                  child: Column(
                                    children: [
                                      SectionTitle(
                                        title: state.categories[index].title,
                                        hasPermission: widget.user.isVerified,
                                        onClick: () {
                                          Navigator.pushNamed(
                                            context,
                                            ProductListScreen.routeName,
                                            arguments: ProductListArguments(
                                              category: state.categories[index],
                                              user: widget.user,
                                            ),
                                          );
                                        },
                                      ),
                                      CharacterCards(
                                        products: state.products
                                            .where(
                                              (element) =>
                                                  element.categoryId ==
                                                  state.categories[index].id,
                                            )
                                            .toList(),
                                        user: widget.user,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const Center()
                  ],
                );
              },
            ),
            const SizedBox(
              height: SizeConfig.defaultPadding / 2,
            ),
          ],
        ),
      ),
    );
  }
}
