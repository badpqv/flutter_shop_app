import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:intl/intl.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding),
          child: Column(
            children: [
              Text(
                product.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: SizeConfig.defaultPadding / 4,
              ),
              Text(
                product.price < product.maxPrice
                    ? "${NumberFormat.simpleCurrency(locale: "vi", decimalDigits: 0).format(product.price)} - ${NumberFormat.simpleCurrency(locale: "vi", decimalDigits: 0).format(product.maxPrice)}"
                    : NumberFormat.simpleCurrency(
                            locale: "vi", decimalDigits: 0)
                        .format(product.price),
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  color: AppColors.primaryColor,
                  overflow: TextOverflow.ellipsis,
                ),
                softWrap: true,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: SizeConfig.defaultPadding / 4,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(SizeConfig.defaultPadding * .75),
            width: 64,
            height: 50,
            decoration: BoxDecoration(
              color: product.isFavourite
                  ? const Color(0xFFFFE6E6)
                  : const Color(0xFFF5F6F9),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(SizeConfig.defaultBorderRadius * 2),
                bottomLeft: Radius.circular(SizeConfig.defaultBorderRadius * 2),
              ),
            ),
            child: Icon(
              Icons.favorite,
              color: product.isFavourite
                  ? const Color(0xFFFF4848)
                  : const Color(0xFFDBDFF4),
              size: 25,
            ),
          ),
        ),
        //ProductDescription
        Padding(
          padding: const EdgeInsets.only(
            left: SizeConfig.defaultPadding,
            right: SizeConfig.defaultPadding * 3,
          ),
          child: Text(
            product.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SizeConfig.defaultPadding,
            vertical: SizeConfig.defaultPadding / 2,
          ),
          child: InkWell(
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                children: const [
                  Text(
                    "Xem thêm",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.defaultPadding / 4,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 12,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
