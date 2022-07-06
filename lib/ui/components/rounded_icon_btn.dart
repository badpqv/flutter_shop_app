import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

class RoundedIconBtn extends StatelessWidget {
  const RoundedIconBtn(
      {Key? key,
      required this.icon,
      required this.onTap,
      this.showShadow = true,
      required this.isEnabled})
      : super(key: key);
  final IconData icon;
  final GestureTapCancelCallback onTap;
  final bool showShadow;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              offset: const Offset(0, 6),
              blurRadius: 10,
              color: const Color(0xFFB0B0B0).withOpacity(0.2),
            ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: primaryColor,
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        onPressed: onTap,
        child: Icon(icon),
      ),
    );
  }
}
