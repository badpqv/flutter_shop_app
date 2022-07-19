import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig.defaultPadding * 3,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(SizeConfig.defaultBorderRadius * 2),
            side: const BorderSide(color: AppColors.primaryColor),
          )),
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.primaryColor),
        ),
        onPressed: press,
        child: Text(
          text!,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
