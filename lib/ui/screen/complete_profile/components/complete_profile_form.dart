import 'package:flutter/material.dart';
import 'package:flutter_shop_app/api_repository/api_repository.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/components/custom_btn.dart';
import 'package:flutter_shop_app/ui/components/form_errors.dart';
import 'package:flutter_shop_app/ui/screen/complete_profile/complete_profile_screen.dart';
import 'package:flutter_shop_app/ui/screen/login/login_screen.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import '../../../../constant_value.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key, required this.args}) : super(key: key);
  final CompleteProfileArguments args;
  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  ApiRepository repository = ApiRepository();
  final _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
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
          horizontal: defaultPadding,
        ),
        child: Column(
          children: [
            const SizedBox(height: defaultPadding),
            buildFirstNameInput(),
            const SizedBox(height: defaultPadding),
            buildLastNameInput(),
            const SizedBox(height: defaultPadding),
            buildPhoneNumberInput(),
            const SizedBox(height: defaultPadding),
            buildAddressInput(),
            const SizedBox(height: defaultPadding),
            FormErrors(errors: errors),
            const SizedBox(height: defaultPadding),
            CustomButton(
              text: "Tiếp tục",
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  repository
                      .register(
                    User(
                      email: widget.args.email,
                      password: widget.args.password,
                      firstName: firstName!,
                      lastName: lastName!,
                      phoneNumber: phoneNumber!,
                      address: address!,
                      isVerified: true,
                    ),
                  )
                      .then(
                    (value) {
                      if (value != const User()) {
                        var snackBar = SnackBar(
                          content: const Text("Đăng ký thành công"),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: primaryColor,
                          action: SnackBarAction(
                            label: "Về đăng nhập",
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.pushNamed(context, LoginPage.routeName);
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildFirstNameInput() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: nullFirstNameError);
        }
      },
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: nullFirstNameError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Họ, tên đệm",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập họ, tên đệm của bạn",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2,
          vertical: defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: defaultPadding,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: defaultPadding,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(FontAwesome.user),
        ),
      ),
    );
  }

  TextFormField buildLastNameInput() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: nullLastNameError);
        }
      },
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: nullLastNameError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Tên",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập tên đệm của bạn",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2,
          vertical: defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: defaultPadding,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: defaultPadding,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(FontAwesome.user),
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberInput() {
    return TextFormField(
      onSaved: (newValue) => phoneNumber = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: nullPhoneError);
        }
      },
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: nullPhoneError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Số điện thoại",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập số điện thoại của bạn",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2,
          vertical: defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: defaultPadding,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: defaultPadding,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.phone_outlined),
        ),
      ),
    );
  }

  TextFormField buildAddressInput() {
    return TextFormField(
      onSaved: (newValue) => address = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: nullAddressError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: nullAddressError);
          return "";
        }
        return null;
      },
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        labelText: "Địa chỉ",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập địa chỉ của bạn",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2,
          vertical: defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: defaultPadding,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: defaultPadding,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(FontAwesome5.address_card),
        ),
      ),
    );
  }
}
