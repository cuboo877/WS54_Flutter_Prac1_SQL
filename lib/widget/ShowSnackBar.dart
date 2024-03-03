import 'package:flutter/material.dart';
import 'package:ws54_flutter_prac1/service/sql_service.dart';

void showSnackBar(BuildContext context) async {
  UserData ud = await DB.getUserDataByActivity();
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text("登入成功!"),
    duration: Duration(seconds: 1),
  ));
  Future.delayed(const Duration(milliseconds: 500));
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("目前使用者: ${ud.username}"),
    duration: const Duration(seconds: 2),
  ));
}

void showCustomSnackBar(BuildContext context, String? content,
    Duration duration, Duration delayed) async {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(content ?? ""), duration: duration));
  await Future.delayed(duration);
}
