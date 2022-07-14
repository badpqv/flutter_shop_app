import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/home/home_screen.dart';
import 'package:flutter_shop_app/ui/screen/profile/profile_screen.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/maki_icons.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    Key? key,
    required this.user,
    required this.selectedMenu,
  }) : super(key: key);
  final User user;
  final Menu selectedMenu;
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
        child: SafeArea(
          top: false,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  if (Menu.home != selectedMenu) {
                    Navigator.pushNamed(
                      context,
                      HomeScreen.routeName,
                      arguments: HomeArguments(user: user),
                    );
                  }
                },
                icon: Icon(
                  Maki.shop,
                  color: Menu.home == selectedMenu ? primaryColor : textColor,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.favorite_border_outlined,
                  color: textColor,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.message_outlined,
                  color: textColor,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  FontAwesome5.user,
                  color:
                      Menu.profile == selectedMenu ? primaryColor : textColor,
                ),
                onPressed: () {
                  if (Menu.profile != selectedMenu) {
                    Navigator.pushNamed(
                      context,
                      ProfileScreen.routeName,
                      arguments: ProfileArguments(user: user),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
