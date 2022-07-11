import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFF88379);
const Color primaryLightColor = Color(0xffFFB6C1);
Color secondaryColor = const Color(0xFF979797);
const Color textColor = Color(0xFF757575);
const Color bgColor = Color(0xFFFAF9F6);
final primaryGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    const Color(0xFFFFA53E).withOpacity(0.5),
    const Color(0xFFFF7643).withOpacity(0.5)
  ],
);
const double defaultPadding = 20.0;
const double defaultBorderRadius = 10;

const animationDuration = Duration(milliseconds: 500);

const nullFirstNameError = "Vui lòng nhập tên của bạn";
const nullLastNameError = "Vui lòng nhập họ và tên đệm của bạn";
const nullEmailError = "Vui lòng nhập địa chỉ email";
const nullPhoneError = " Vui lòng nhập số điện thoại của bạn";
const nullAddressError = " Vui lòng nhập địa chỉ của bạn";
const invalidEmailError = "Địa chỉ email không hợp lệ";
const nullPassError = "Vui lòng nhập mật khẩu";
const shortPassError = "Mật khẩu quá ngắn. Vui lòng nhập lại mật khẩu";
const matchPassError = "Mật khẩu và xác nhận mật khẩu không khớp";
const loginError = "Đăng nhập thất bại \n sai tên tài khoản hoặc mật khẩu";
RegExp emailValidatoreRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

const headingStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 30,
  color: primaryColor,
  height: 1.5,
);
final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(
    vertical: defaultPadding,
  ),
  enabledBorder: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
);
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(defaultBorderRadius),
    borderSide: const BorderSide(color: textColor),
  );
}

List<Map<String, String>> splashData = [
  {
    "text": 'Hiện đại nhất Việt Nam\nChất lượng "ơ mây zing gút chóp" :3!',
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
