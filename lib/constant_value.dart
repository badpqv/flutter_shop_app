import 'package:flutter/material.dart';

// #region main variables in project
class AppColors {
  static const Color primaryColor = Color(0xFF5D3FD3);
  static const Color primaryLightColor = Color(0xffFFB6C1);
  static const Color secondaryColor = Color(0xFF979797);
  static const Color textColor = Color(0xFF757575);
  static const Color bgColor = Color(0xFFFAF9F6);
  static final primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFA53E).withOpacity(0.5),
      Color(0xFFFF7643).withOpacity(0.5)
    ],
  );
}

class SizeConfig {
  static const double defaultPadding = 20.0;
  static const double defaultBorderRadius = 10;
  static const animationDuration = Duration(milliseconds: 500);
}

class AppErrors {
  static const nullFirstNameError = "Vui lòng nhập họ và tên đệm của bạn";
  static const nullLastNameError = "Vui lòng nhập tên của bạn";
  static const nullEmailError = "Vui lòng nhập địa chỉ email";
  static const nullPhoneError = " Vui lòng nhập số điện thoại của bạn";
  static const nullAddressError = " Vui lòng nhập địa chỉ của bạn";
  static const invalidEmailError = "Địa chỉ email không hợp lệ";
  static const nullPassError = "Vui lòng nhập mật khẩu";
  static const shortPassError = "Mật khẩu quá ngắn. Vui lòng nhập lại mật khẩu";
  static const matchPassError = "Mật khẩu và xác nhận mật khẩu không khớp";
  static const loginError =
      "Đăng nhập thất bại \n sai tên tài khoản hoặc mật khẩu";

  static const nullProductNameError = "Vui lòng nhập tên sản phẩm";

  static final RegExp emailValidatoreRegExp =
      RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
}

class AppStyle {
  static const headingStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30,
    color: AppColors.primaryColor,
    height: 1.5,
  );
  final otpInputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
      vertical: SizeConfig.defaultPadding,
    ),
    enabledBorder: outlineInputBorder(),
    focusedBorder: outlineInputBorder(),
  );
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
    borderSide: const BorderSide(color: AppColors.primaryColor),
  );
}

List<Map<String, String>> splashData = [
  {
    "text": 'Chất lượng "ơ mây zing gút chóp" :3!',
    "image": "assets/images/March7th_1.png"
  },
  {
    "text": 'Đổi trả miễn phí',
    "image": "assets/images/March7th_2.png",
  },
  {
    "text": "Ship hàng tận tay",
    "image": "assets/images/March7th_3.png",
  },
];

List<ImageProvider> avatars = [
  const AssetImage("assets/images/March7th_1.png"),
  const AssetImage("assets/images/March7th_2.png"),
  const AssetImage("assets/images/March7th_3.png"),
];

enum Menu { home, favourite, message, profile }
