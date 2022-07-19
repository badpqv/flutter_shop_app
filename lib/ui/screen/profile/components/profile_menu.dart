import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.title,
    required this.onClick,
    required this.icon,
  }) : super(key: key);
  final String title;
  final VoidCallback onClick;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultPadding,
          vertical: SizeConfig.defaultPadding / 2),
      child: TextButton(
        onPressed: onClick,
        style: TextButton.styleFrom(
          primary: AppColors.primaryColor,
          padding: const EdgeInsets.all(SizeConfig.defaultPadding),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(SizeConfig.defaultBorderRadius * 2),
          ),
          backgroundColor: const Color(0xFFFAF9F6),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: SizeConfig.defaultPadding / 2,
            ),
            Icon(
              icon,
              color: AppColors.primaryColor,
              size: 40,
            ),
            const SizedBox(
              width: SizeConfig.defaultPadding / 2,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
