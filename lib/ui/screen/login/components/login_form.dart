import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/ui/screen/login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shop_app/components/custom_btn.dart';
import 'package:flutter_shop_app/components/form_errors.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/forgot_password/forgot_pass_screen.dart';

import 'package:flutter_shop_app/ui/screen/login/login_success_screen.dart';

import '../../../../constant_value.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String email = "";
  String password = "";
  bool remember = false;
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailImput(),
          const SizedBox(
            height: defaultPadding,
          ),
          buildPassWordInput(),
          const SizedBox(
            height: defaultPadding,
          ),
          Row(
            children: [
              Checkbox(
                  value: remember,
                  fillColor: MaterialStateProperty.all<Color>(primaryColor),
                  checkColor: Colors.white,
                  onChanged: (bool? value) {
                    setState(() {
                      remember = value!;
                    });
                  }),
              const Text(
                "Ghi nhớ tài khoản",
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, ForgotPasswordScreen.routeName);
                  },
                  child: const Text(
                    "Quên mật khẩu?",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ))
            ],
          ),
          FormErrors(errors: errors),
          const SizedBox(height: defaultPadding / 2),
          CustomButton(
            text: "Đăng nhập",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPassWordInput() {
    return TextFormField(
      controller: passController,
      enableSuggestions: false,
      autocorrect: false,
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: nullPassError);
        } else if (value.length >= 6) {
          removeError(error: shortPassError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: nullPassError);
          return "";
        } else if (value.length < 6) {
          addError(error: shortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập mật khẩu của bạn",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2,
          vertical: defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            borderSide: const BorderSide(color: Colors.grey),
            gapPadding: defaultPadding),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: defaultPadding,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.vpn_key_outlined),
        ),
      ),
    );
  }

  TextFormField buildEmailImput() {
    return TextFormField(
      controller: emailController,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: nullEmailError);
        } else if (emailValidatoreRegExp.hasMatch(value)) {
          removeError(error: invalidEmailError);
        }
      },
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: nullEmailError);
          return "";
        } else if (!emailValidatoreRegExp.hasMatch(value)) {
          addError(error: invalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập email của bạn",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2,
          vertical: defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            borderSide: const BorderSide(color: Colors.grey),
            gapPadding: defaultPadding),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: defaultPadding,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.email_outlined),
        ),
      ),
    );
  }
}
