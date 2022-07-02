import 'package:flutter/material.dart';
import 'package:flutter_shop_app/ui/screen/splash/components/splash_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routeName = "/";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      body: SplashBody(),
    );
  }
}
