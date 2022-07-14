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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            const SizedBox(
              height: defaultPadding / 2,
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                return Column(
                  children: [
                    const SizedBox(
                      height: defaultPadding / 2,
                    ),
                    state is ProductLoaded
                        ? Column(
                            children: [
                              ...List.generate(
                                state.categories.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding / 2,
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
                                              callBack: refreshBlocState,
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
              height: defaultPadding / 2,
            ),
          ],
        ),
      ),
    );
  }
}
