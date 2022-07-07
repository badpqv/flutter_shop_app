import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constant_value.dart';

class AvatarBox extends StatelessWidget {
  const AvatarBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              backgroundImage: avatars[Random().nextInt(avatars.length)],
            ),
            Positioned(
              right: -16,
              bottom: 0,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueGrey[200],
                ),
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
