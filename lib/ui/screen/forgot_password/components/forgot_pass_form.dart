import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/components/custom_btn.dart';
import 'package:flutter_shop_app/ui/components/form_errors.dart';
import 'package:flutter_shop_app/ui/screen/login/login_screen.dart';
import 'package:flutter_shop_app/ui/screen/register/register_screen.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String? email;
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
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: SizeConfig.defaultPadding * 3,
          ),
          buildEmailImput(),
          const SizedBox(
            height: SizeConfig.defaultPadding / 2,
          ),
          FormErrors(errors: errors),
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
          ),
          CustomButton(
            text: "Tiếp tục",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.pushNamed(context, LoginPage.routeName);
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Không có tài khoản?",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child: const Text(
                  "Đăng ký",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.primaryColor,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailImput() {
    return TextFormField(
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppErrors.nullEmailError);
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
