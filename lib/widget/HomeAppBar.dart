import 'package:flutter/material.dart';
import 'package:ws54_flutter_prac1/constant/color_style.dart';

Widget HomeAppBar(BuildContext context) {
  return AppBar(
    title: const Text(
      "主畫面",
      style: TextStyle(color: StyleColor.white),
    ),
    centerTitle: true,
    iconTheme: const IconThemeData(color: StyleColor.white),
    backgroundColor: StyleColor.darkBlue,
  );
}
