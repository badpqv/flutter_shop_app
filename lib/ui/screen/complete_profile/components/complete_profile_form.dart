import 'package:flutter/material.dart';
import 'package:flutter_shop_app/components/custom_btn.dart';
import 'package:flutter_shop_app/components/form_errors.dart';

import 'package:flutter_shop_app/ui/screen/otp/otp_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constant_value.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
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
            buildLastNameInput(),
            const SizedBox(height: defaultPadding),
            buildFirstNameInput(),
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
                  Navigator.pushNamed(context, OtpScreen.routeName);
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
        labelText: "Tên",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập tên của bạn",
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
          child: Icon(FontAwesomeIcons.user),
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
          child: Icon(FontAwesomeIcons.user),
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
          child: Icon(FontAwesomeIcons.addressCard),
        ),
      ),
    );
  }
}
