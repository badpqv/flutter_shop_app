import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

class NameBox extends StatelessWidget {
  const NameBox({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
  }) : super(key: key);
  final String firstName;
  final String lastName;
  final bool isVerified;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$firstName $lastName",
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          width: defaultPadding / 4,
        ),
        Icon(
          Icons.verified_user,
          color: isVerified ? primaryColor : Colors.grey,
          size: 20,
        ),
      ],
    );
  }
}
