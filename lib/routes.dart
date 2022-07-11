import 'package:flutter/material.dart';
import 'package:flutter_shop_app/ui/screen/complete_profile/complete_profile_screen.dart';
import 'package:flutter_shop_app/ui/screen/details/details_screen.dart';
import 'package:flutter_shop_app/ui/screen/forgot_password/forgot_pass_screen.dart';
import 'package:flutter_shop_app/ui/screen/home/home_screen.dart';
import 'package:flutter_shop_app/ui/screen/login/login_screen.dart';
import 'package:flutter_shop_app/ui/screen/login/login_success_screen.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/product_list.dart';
import 'package:flutter_shop_app/ui/screen/profile/profile_screen.dart';
import 'package:flutter_shop_app/ui/screen/register/register_screen.dart';
import 'package:flutter_shop_app/ui/screen/shopping_cart/cart_screen.dart';

import 'package:flutter_shop_app/ui/screen/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  LoginPage.routeName: (context) => const LoginPage(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProductListScreen.routeName: (context) => const ProductListScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
};
