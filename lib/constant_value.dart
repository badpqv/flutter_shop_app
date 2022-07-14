import 'package:flutter/material.dart';

// #region main variables in project
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
// #endregion

const nullFirstNameError = "Vui lòng nhập họ và tên đệm của bạn";
const nullLastNameError = "Vui lòng nhập tên của bạn";
const nullEmailError = "Vui lòng nhập địa chỉ email";
const nullPhoneError = " Vui lòng nhập số điện thoại của bạn";
const nullAddressError = " Vui lòng nhập địa chỉ của bạn";
const invalidEmailError = "Địa chỉ email không hợp lệ";
const nullPassError = "Vui lòng nhập mật khẩu";
const shortPassError = "Mật khẩu quá ngắn. Vui lòng nhập lại mật khẩu";
const matchPassError = "Mật khẩu và xác nhận mật khẩu không khớp";
const loginError = "Đăng nhập thất bại \n sai tên tài khoản hoặc mật khẩu";

const nullProductNameError = "Vui lòng nhập tên sản phẩm";

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
    "image": "http://192.168.1.5:5000/images/march7th_1.jpg"
  },
  {
    "text": 'Đổi trả miễn phí',
    "image": "http://192.168.1.5:5000/images/march7th_2.jpg",
  },
  {
    "text": "Ship hàng tận tay",
    "image": "http://192.168.1.5:5000/images/march7th_3.jpg",
  },
];

List<ImageProvider> avatars = [
  const NetworkImage("http://192.168.1.5:5000/images/march7th_1.jpg"),
  const NetworkImage("http://192.168.1.5:5000/images/march7th_2.jpg"),
  const NetworkImage("http://192.168.1.5:5000/images/march7th_3.jpg"),
];

enum Menu { home, favourite, message, profile }
