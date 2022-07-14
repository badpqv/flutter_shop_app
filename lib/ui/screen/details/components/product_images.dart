import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/product_model.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
    required this.callbacks,
  }) : super(key: key);

  final Product product;
  final List<Function> callbacks;
  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: 238,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                  widget.product.images.split(",")[selectedImage]),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                  widget.product.images.split(",").length,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 4,
                        ),
                        child: buildSmallPreview(index),
                      )),
            ],
          ),
        )
      ],
    );
  }

  GestureDetector buildSmallPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
        widget.callbacks[0](index);
        widget.callbacks[1](index);
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding / 2),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          border: Border.all(
            color: selectedImage == index ? primaryColor : Colors.transparent,
          ),
        ),
        child: Image.network(widget.product.images.split(",")[index]),
      ),
    );
  }
}

//create arguments to pass data  with name route