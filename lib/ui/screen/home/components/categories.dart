import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/ui/screen/home/components/category_card.dart';

import 'package:flutter_svg/flutter_svg.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key, required this.categories}) : super(key: key);
  final List<Category> categories;
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding / 2),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            widget.categories.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultPadding / 2,
              ),
              child: CategoryCard(
                category: widget.categories[index].title,
                image: widget.categories[index].icon,
                numberOfBrands: widget.categories[index].products.length,
                onTap: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
