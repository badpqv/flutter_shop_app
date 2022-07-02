import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/screen/home/components/home_body.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const HomeScreenBody(),
        bottomNavigationBar: BottomAppBar(
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
              color: Colors.white54,
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
              children: [
                Column(
                  children: [
                    SvgPicture.asset("assets/icons/Shop.svg"),
                    const Icon(
                      Icons.more_rounded,
                      size: 5,
                      color: primaryColor,
                    ),
                  ],
                ),
                const Icon(
                  Icons.favorite_border_outlined,
                  color: textColor,
                ),
                SvgPicture.asset("assets/icons/message.svg"),
                const Icon(
                  FontAwesomeIcons.user,
                  color: textColor,
                ),
              ],
            ),
          ),
        ));
  }
}
