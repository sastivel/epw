import 'package:flutter/material.dart';

import '../../utils/color_resource.dart';

class CustomDialogs {
  static AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(
          color: ColorResource.Color_FF6767,
        ),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...")),
      ],
    ),
  );
  static void showCustomDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomDialogs.alert;
      },
    );
  }

  showLoaderDialog(BuildContext context) {}
}
