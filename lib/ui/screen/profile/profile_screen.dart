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
    final ProfileArguments args =
        ModalRoute.of(context)!.settings.arguments as ProfileArguments;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .9,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: SizeConfig.defaultPadding / 2,
            horizontal: SizeConfig.defaultPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AvatarBox(),
                const SizedBox(
                  height: SizeConfig.defaultPadding,
                ),
                NameBox(
                  firstName: args.user.firstName,
                  lastName: args.user.lastName,
                  isVerified: args.user.isVerified,
                ),
                const SizedBox(
                  height: SizeConfig.defaultPadding,
                ),
                ProfileMenu(
                  title: "T??i kho???n c???a t??i",
                  onClick: () {},
                  icon: Icons.person_outline,
                ),
                ProfileMenu(
                  title: "C??i ?????t t??i kho???n",
                  onClick: () {},
                  icon: Icons.settings_outlined,
                ),
                ProfileMenu(
                  title: "L???ch s??? ho???t ?????ng",
                  onClick: () {},
                  icon: Icons.history_outlined,
                ),
                ProfileMenu(
                  title: "????ng xu???t",
                  onClick: () {
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName(
                        LoginPage.routeName,
                      ),
                    );
                  },
                  icon: Icons.logout_outlined,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        user: args.user,
        selectedMenu: Menu.profile,
      ),
    );
  }
}

class ProfileArguments {
  final User user;
  const ProfileArguments({required this.user});
}
