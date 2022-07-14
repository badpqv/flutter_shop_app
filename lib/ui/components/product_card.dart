import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key,
      this.width = 140,
      this.ratio = 1.02,
      required this.product,
      required this.onTap})
      : super(key: key);
  final double width, ratio;
  final GestureTapCallback onTap;
  final Product product;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 140,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: ratio,
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    defaultBorderRadius * 1.5,
                  ),
                ),
                child: Image.network(product.images.split(",")[0]),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              product.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: textColor,
                overflow: TextOverflow.fade,
              ),
              maxLines: 1,
              softWrap: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  NumberFormat.simpleCurrency(locale: "vi", decimalDigits: 0)
                      .format(product.price),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    color: primaryColor,
                  ),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: product.isFavourite
                        ? const Color(0xFFFFE6E6)
                        : const Color(0xFFF5F6F9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_rounded,
                    color: product.isFavourite
                        ? const Color(0xFFFF4848)
                        : const Color(0xFFDBDFF4),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
