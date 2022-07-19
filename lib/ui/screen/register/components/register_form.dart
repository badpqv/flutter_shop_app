import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/components/custom_btn.dart';
import 'package:flutter_shop_app/ui/components/form_errors.dart';
import 'package:flutter_shop_app/ui/screen/complete_profile/complete_profile_screen.dart';

import '../../../../constant_value.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPass;
  final List<String> errors = [];
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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: SizeConfig.defaultPadding),
              buildEmailFormField(),
              const SizedBox(height: SizeConfig.defaultPadding),
              buildPasswordFormField(),
              const SizedBox(height: SizeConfig.defaultPadding),
              TextFormField(
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                onChanged: (value) {
                  if (password == value) {
                    removeError(error: AppErrors.matchPassError);
                  }
                  confirmPass = value;
                },
                validator: (value) {
                  if (password != value) {
                    addError(error: AppErrors.matchPassError);
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Xác nhận mật khẩu",
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: SizeConfig.defaultPadding * 2,
                    vertical: SizeConfig.defaultPadding * 1.5,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(SizeConfig.defaultBorderRadius),
                      borderSide: const BorderSide(color: Colors.grey),
                      gapPadding: SizeConfig.defaultPadding),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.defaultBorderRadius),
                    borderSide: const BorderSide(color: Colors.grey),
                    gapPadding: SizeConfig.defaultPadding,
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultPadding),
                    child: Icon(Icons.vpn_key_outlined),
                  ),
                ),
              ),
              const SizedBox(height: SizeConfig.defaultPadding * 2),
              FormErrors(errors: errors),
              CustomButton(
                text: "Tiếp tục",
                press: () {
                  if (_formKey.currentState!.validate() && errors.isEmpty) {
                    _formKey.currentState!.save();
                    Navigator.pushNamed(
                      context,
                      CompleteProfileScreen.routeName,
                      arguments: CompleteProfileArguments(
                        email: email!,
                        password: password!,
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      onSaved: ((newValue) {
        password = newValue!;
      }),
      enableSuggestions: false,
      autocorrect: false,
      obscureText: true,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppErrors.nullPassError);
        } else if (value.length >= 6) {
          removeError(error: AppErrors.shortPassError);
        }
        password = value;
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
}
