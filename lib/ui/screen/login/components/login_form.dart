import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/api_repository/api_repository.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/components/custom_btn.dart';
import 'package:flutter_shop_app/ui/components/form_errors.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/forgot_password/forgot_pass_screen.dart';

import 'package:flutter_shop_app/ui/screen/login/login_success_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final ApiRepository repository = ApiRepository();
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
            height: SizeConfig.defaultPadding,
          ),
          buildPassWordInput(),
          const SizedBox(
            height: SizeConfig.defaultPadding,
          ),
          Row(
            children: [
              Checkbox(
                  value: remember,
                  fillColor:
                      MaterialStateProperty.all<Color>(AppColors.primaryColor),
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
          const SizedBox(height: SizeConfig.defaultPadding / 2),
          CustomButton(
            text: "Đăng nhập",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                var user = User(
                  email: email,
                  password: password,
                );
                repository.login(user).then(
                      (value) => value == const User()
                          ? addError(error: AppErrors.loginError)
                          : Navigator.pushNamed(
                              context,
                              LoginSuccessScreen.routeName,
                              arguments: LoginSuccessArguments(user: value),
                            ),
                    );
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
        removeError(error: AppErrors.loginError);

        if (value.isNotEmpty) {
          removeError(error: AppErrors.nullPassError);
        } else if (value.length >= 6) {
          removeError(error: AppErrors.shortPassError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppErrors.nullPassError);
          return "";
        } else if (value.length < 6) {
          addError(error: AppErrors.shortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập mật khẩu của bạn",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultPadding * 2,
          vertical: SizeConfig.defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
            borderSide: const BorderSide(color: Colors.grey),
            gapPadding: SizeConfig.defaultPadding),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: SizeConfig.defaultPadding,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(SizeConfig.defaultPadding),
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
        removeError(error: AppErrors.nullEmailError);

        if (value.isNotEmpty) {
          removeError(error: AppErrors.loginError);
        } else if (AppErrors.emailValidatoreRegExp.hasMatch(value)) {
          removeError(error: AppErrors.invalidEmailError);
        }
      },
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppErrors.nullEmailError);
          return "";
        } else if (!AppErrors.emailValidatoreRegExp.hasMatch(value)) {
          addError(error: AppErrors.invalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập email của bạn",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultPadding * 2,
          vertical: SizeConfig.defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
            borderSide: const BorderSide(color: Colors.grey),
            gapPadding: SizeConfig.defaultPadding),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: SizeConfig.defaultPadding,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(SizeConfig.defaultPadding),
          child: Icon(Icons.email_outlined),
        ),
      ),
    );
  }
}
