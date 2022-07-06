import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/home/home_screen.dart';
import 'package:flutter_shop_app/ui/screen/profile/profile_screen.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: AutomaticNotchedShape(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius * 2)),
        const StadiumBorder(),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding * .75,
          horizontal: defaultPadding * 1.5,
        ),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(defaultBorderRadius * 3),
            topRight: Radius.circular(defaultBorderRadius * 3),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDADADA).withOpacity(.15),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  HomeScreen.routeName,
                  arguments: user,
                );
              },
              child: const Icon(
                Maki.shop,
                color: primaryColor,
              ),
            ),
            const Icon(
              Icons.favorite_border_outlined,
              color: textColor,
            ),
            const Icon(
              FontAwesomeIcons.message,
              color: textColor,
            ),
            GestureDetector(
              child: const Icon(FontAwesomeIcons.user),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ProfileScreen.routeName,
                  arguments: user,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
