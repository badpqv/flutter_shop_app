import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/ui/components/rounded_icon_btn.dart';

class LightNovelType extends StatefulWidget {
  const LightNovelType(
      {Key? key,
      required this.product,
      required this.onTypeSelect,
      required this.quantityGetter})
      : super(key: key);
  final Product product;
  final Function onTypeSelect;
  final Function quantityGetter;
  @override
  State<LightNovelType> createState() => _LightNovelTypeState();
}

class _LightNovelTypeState extends State<LightNovelType> {
  String selectedType = "Bản thông thường";
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...List.generate(
              widget.product.colors.split(",").length,
              (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = widget.product.colors.split(",")[index];
                    });
                    widget.onTypeSelect(selectedType);
                  },
                  child: TypeSelectCard(
                      selectedType: selectedType,
                      product: widget.product,
                      index: index)),
            ),
          ],
        ),
        Row(
          children: [
            RoundedIconBtn(
              icon: Icons.remove,
              onTap: () {
                setState(() {
                  quantity--;
                  if (quantity <= 1) quantity = 1;
                  widget.quantityGetter(quantity);
                });
              },
              showShadow: true,
              isEnabled: quantity == 1 ? false : true,
            ),
            const SizedBox(
              width: SizeConfig.defaultPadding,
            ),
            Text(
              "$quantity",
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: SizeConfig.defaultPadding,
            ),
            RoundedIconBtn(
              icon: Icons.add,
              onTap: () {
                setState(() {
                  quantity++;
                });
                widget.quantityGetter(quantity);
              },
              showShadow: true,
              isEnabled: true,
            ),
          ],
        )
      ],
    );
  }
}

class TypeSelectCard extends StatelessWidget {
  const TypeSelectCard({
    Key? key,
    required this.selectedType,
    required this.product,
    required this.index,
  }) : super(key: key);

  final String selectedType;
  final Product product;
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Chip(
        backgroundColor: Colors.white,
        avatar: CircleAvatar(
          backgroundColor: product.colors.split(",")[index] == selectedType
              ? Colors.blue
              : Colors.grey,
          child: const Icon(Icons.check),
        ),
        label: Text(product.colors.split(",")[index]),
      ),
    );
  }
}
