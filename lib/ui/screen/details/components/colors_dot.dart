import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/ui/components/rounded_icon_btn.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
    required this.product,
    required this.callback,
    required this.quantityGetter,
  }) : super(key: key);

  final Product product;
  final Function callback;
  final Function quantityGetter;
  @override
  State<ColorDots> createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int quantity = 1;
  int selectedColor = 0;
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(text: quantity.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          widget.product.colors.split(",").length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = index;
              });
              widget.callback(index);
            },
            child: ColorDot(
              color: Color(
                int.parse(widget.product.colors.split(",")[index]),
              ),
              isSelected: selectedColor == index,
            ),
          ),
        ),
        const Spacer(),
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
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({Key? key, required this.color, required this.isSelected})
      : super(key: key);
  final Color color;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
          ),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: 10,
          backgroundColor: color,
        ),
      ),
    );
  }
}
