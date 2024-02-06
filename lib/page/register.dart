import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ws54_flutter_prac1/constant/color_style.dart';
import 'package:ws54_flutter_prac1/constant/content.dart';
import 'package:ws54_flutter_prac1/page/login.dart';
import 'package:ws54_flutter_prac1/service/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isAcctCorrect = true;
  bool _isPwdCorrect = true;
  bool _isConfirmCorrect = true;

  // ignore: non_constant_identifier_names
  late TextEditingController account_controller;
  // ignore: non_constant_identifier_names
  late TextEditingController password_controller;
  // ignore: non_constant_identifier_names
  late TextEditingController confirm_controller;

  @override
  void initState() {
    super.initState();
    account_controller = TextEditingController();
    password_controller = TextEditingController();
    confirm_controller = TextEditingController();
  }

  @override
  void dispose() {
    account_controller.dispose();
    password_controller.dispose();
    confirm_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: StyleColor.white,
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  width: 500,
                  height: 80,
                  decoration: const BoxDecoration(
                      color: StyleColor.darkBlue,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(200, 150),
                          bottomRight: Radius.elliptical(200, 150))),
                  child: const Text("註冊",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: StyleColor.white)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "帳號",
                  style: TextStyle(
                      color: StyleColor.darkBlue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 320,
                  child: TextFormField(
                    controller: account_controller,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        _isAcctCorrect = false;
                        return "請輸入您的帳號";
                      } else if (!value.endsWith("@gmail.com")) {
                        _isAcctCorrect = false;
                        return "不可用的帳號類型";
                      } else {
                        _isAcctCorrect = true;
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon:
                            const Icon(color: StyleColor.lightgrey, Icons.mail),
                        hintText: "Email",
                        hintStyle: const TextStyle(color: StyleColor.lightgrey),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: StyleColor.lightgrey),
                            borderRadius: BorderRadius.circular(45))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "密碼",
                  style: TextStyle(
                      color: StyleColor.darkBlue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 320,
                  child: TextFormField(
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal),
                    controller: password_controller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _isPwdCorrect = false;
                        return '請設置此帳號的密碼';
                      } else if (value.length < 8) {
                        _isPwdCorrect = false;
                        return "密碼長度至少為8";
                      } else if (value.length > 25) {
                        _isPwdCorrect = false;
                        return "密碼長度過長，需小於25";
                      }
                      _isPwdCorrect = true;
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon:
                            const Icon(color: StyleColor.lightgrey, Icons.key),
                        hintText: "Password",
                        hintStyle: const TextStyle(color: StyleColor.lightgrey),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: StyleColor.lightgrey),
                            borderRadius: BorderRadius.circular(45))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 320,
                  child: TextFormField(
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal),
                    controller: confirm_controller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      String? pwd = password_controller.text;
                      if (pwd.isEmpty) {
                        _isConfirmCorrect = false;
                        return "請先設置密碼";
                      } else if (pwd != value.toString()) {
                        _isConfirmCorrect = false;
                        return "錯誤! 請重新輸入密碼";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon:
                            const Icon(color: StyleColor.lightgrey, Icons.key),
                        hintText: "Confirm Password",
                        hintStyle: const TextStyle(color: StyleColor.lightgrey),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: StyleColor.lightgrey),
                            borderRadius: BorderRadius.circular(45))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '登入後，即同意我們的',
                      style: TextStyle(fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                backgroundColor: StyleColor.white,
                                title: const Text("使用條款"),
                                content: SingleChildScrollView(
                                  child: Text(Static_Content.term_of_use),
                                ),
                              );
                            }));
                      },
                      child: const Text(
                        "使用條款",
                        style:
                            TextStyle(color: StyleColor.darkBlue, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    alignment: Alignment.center,
                    width: 250,
                    height: 60,
                    decoration: BoxDecoration(
                        color: StyleColor.darkBlue,
                        borderRadius: BorderRadius.circular(45)),
                    child: GestureDetector(
                      onTap: () async {
                        String acct = account_controller.text;
                        String pwd = password_controller.text;
                        if (_isAcctCorrect &&
                            _isConfirmCorrect &&
                            _isPwdCorrect) {}
                      },
                      child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "註冊",
                              style: TextStyle(
                                  color: StyleColor.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: StyleColor.white,
                            ),
                          ]),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Text("已經擁有帳號了?", style: Theme.of(context).textTheme.bodySmall),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                      },
                      child: const Text(
                        "登入",
                        style: TextStyle(color: StyleColor.darkBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
