import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/services/category_services.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            widget.categories.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2,
              ),
              child: CategoryCard(
                icon: widget.categories[index].icon,
                title: widget.categories[index].title,
                onClick: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.onClick,
  }) : super(key: key);

  final String icon, title;
  final GestureTapCallback onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: SizedBox(
        width: 70,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: SvgPicture.asset(icon),
              ),
            ),
            const SizedBox(
              height: defaultPadding / 4,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
