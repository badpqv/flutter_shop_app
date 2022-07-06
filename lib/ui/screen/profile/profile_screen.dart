import 'package:flutter/material.dart';
import 'package:flutter_shop_app/ui/components/custom_bottom_nav.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/login/login_screen.dart';
import 'package:flutter_shop_app/ui/screen/profile/components/avatar_box.dart';
import 'package:flutter_shop_app/ui/screen/profile/components/name_box.dart';
import 'package:flutter_shop_app/ui/screen/profile/components/profile_menu.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: primaryColor,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .9,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding / 2,
            horizontal: defaultPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AvatarBox(),
                const SizedBox(
                  height: defaultPadding,
                ),
                NameBox(
                  firstName: user.firstName,
                  lastName: user.lastName,
                  isVerified: user.isVerified,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                ProfileMenu(
                  title: "Tài khoản của tôi",
                  onClick: () {},
                  icon: Icons.person_outline,
                ),
                ProfileMenu(
                  title: "Cài đặt tài khoản",
                  onClick: () {},
                  icon: Icons.settings_outlined,
                ),
                ProfileMenu(
                  title: "Lịch sử hoạt động",
                  onClick: () {},
                  icon: Icons.history_outlined,
                ),
                ProfileMenu(
                  title: "Đăng xuất",
                  onClick: () {
                    Navigator.pushNamed(context, LoginPage.routeName);
                  },
                  icon: Icons.logout_outlined,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        user: user,
      ),
    );
  }
}

class ProfileArguments {
  final User user;
  const ProfileArguments({required this.user});
}