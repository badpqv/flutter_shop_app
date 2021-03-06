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
          horizontal: SizeConfig.defaultPadding,
        ),
        child: Column(
          children: [
            const SizedBox(height: SizeConfig.defaultPadding),
            buildFirstNameInput(),
            const SizedBox(height: SizeConfig.defaultPadding),
            buildLastNameInput(),
            const SizedBox(height: SizeConfig.defaultPadding),
            buildPhoneNumberInput(),
            const SizedBox(height: SizeConfig.defaultPadding),
            buildAddressInput(),
            const SizedBox(height: SizeConfig.defaultPadding),
            FormErrors(errors: errors),
            const SizedBox(height: SizeConfig.defaultPadding),
            CustomButton(
              text: "Ti???p t???c",
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
                          content: const Text("????ng k?? th??nh c??ng"),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: AppColors.primaryColor,
                          action: SnackBarAction(
                            label: "V??? ????ng nh???p",
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
          removeError(error: AppErrors.nullFirstNameError);
        }
      },
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppErrors.nullFirstNameError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "H???, t??n ?????m",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nh???p h???, t??n ?????m c???a b???n",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultPadding * 2,
          vertical: SizeConfig.defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: SizeConfig.defaultPadding,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: SizeConfig.defaultPadding,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(SizeConfig.defaultPadding),
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
          removeError(error: AppErrors.nullLastNameError);
        }
      },
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppErrors.nullLastNameError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "T??n",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nh???p t??n ?????m c???a b???n",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultPadding * 2,
          vertical: SizeConfig.defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: SizeConfig.defaultPadding,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: SizeConfig.defaultPadding,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(SizeConfig.defaultPadding),
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
          removeError(error: AppErrors.nullPhoneError);
        }
      },
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppErrors.nullPhoneError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "S??? ??i???n tho???i",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nh???p s??? ??i???n tho???i c???a b???n",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultPadding * 2,
          vertical: SizeConfig.defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: SizeConfig.defaultPadding,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: SizeConfig.defaultPadding,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(SizeConfig.defaultPadding),
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
          removeError(error: AppErrors.nullAddressError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppErrors.nullAddressError);
          return "";
        }
        return null;
      },
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        labelText: "?????a ch???",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nh???p ?????a ch??? c???a b???n",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultPadding * 2,
          vertical: SizeConfig.defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: SizeConfig.defaultPadding,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: SizeConfig.defaultPadding,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(SizeConfig.defaultPadding),
          child: Icon(FontAwesome5.address_card),
        ),
      ),
    );
  }
}
