import 'package:flutter/material.dart';
import 'package:ws54_flutter_prac1/constant/color_style.dart';
import 'package:ws54_flutter_prac1/constant/content.dart';
import 'package:ws54_flutter_prac1/page/register.dart';
import 'package:ws54_flutter_prac1/service/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _StateLoginPage();
}

class _StateLoginPage extends State<LoginPage> {
  late TextEditingController account_controller;
  late TextEditingController password_controller;

  var _isLoginSuccessful;
  bool _isAcctValid = false;
  bool _isPwdValid = false;
  @override
  void initState() {
    super.initState();
    account_controller = TextEditingController();
    password_controller = TextEditingController();
  }

  @override
  void dispose() {
    account_controller.dispose();
    password_controller.dispose();
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
                    child: const Text("登入",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: StyleColor.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "帳號",
                          style: TextStyle(
                              color: StyleColor.darkBlue,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 320,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: account_controller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null) {
                                _isAcctValid = false;
                                return "請輸入您的email";
                              } else if (!value.endsWith("@gmail.com")) {
                                _isAcctValid = false;
                                return "不可用的帳號類型";
                              } else if (_isLoginSuccessful != null) {
                                if (_isLoginSuccessful == false) {
                                  _isAcctValid = false;
                                  return "錯誤的帳號或密碼";
                                } else {
                                  _isAcctValid = true;
                                  return null;
                                }
                              } else {
                                _isAcctValid = true;
                                return null;
                              }
                            },
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    color: StyleColor.lightgrey, Icons.mail),
                                hintText: "Email",
                                hintStyle: const TextStyle(
                                    color: StyleColor.lightgrey),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: StyleColor.lightgrey),
                                    borderRadius: BorderRadius.circular(45))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "密碼",
                          style: TextStyle(
                              color: StyleColor.darkBlue,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 320,
                          child: TextFormField(
                            controller: password_controller,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                _isPwdValid = false;
                                return "請輸入您的密碼";
                              } else if (!_isPwdValid && !_isAcctValid) {
                                return "錯誤的帳號或密碼";
                              } else if (_isLoginSuccessful != null) {
                                if (_isLoginSuccessful == false) {
                                  _isPwdValid = false;
                                  return "錯誤的帳號或密碼";
                                } else {
                                  _isPwdValid = true;
                                  return null;
                                }
                              } else {
                                _isPwdValid = true;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    color: StyleColor.lightgrey, Icons.key),
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                    color: StyleColor.lightgrey),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: StyleColor.lightgrey),
                                    borderRadius: BorderRadius.circular(45))),
                          ),
                        ),
                        // SizedBox(
                        //   width: 320,
                        //   child: TextFormField(
                        //     style: const TextStyle(
                        //         fontSize: 15, fontWeight: FontWeight.normal),
                        //     decoration: InputDecoration(
                        //         prefixIcon: const Icon(
                        //             color: StyleColor.lightgrey, Icons.key),
                        //         hintText: "Verification Code",
                        //         hintStyle:
                        //             const TextStyle(color: StyleColor.lightgrey),
                        //         border: OutlineInputBorder(
                        //             borderSide:
                        //                 const BorderSide(color: StyleColor.lightgrey),
                        //             borderRadius: BorderRadius.circular(45))),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                          content: SizedBox(
                                            width: 270,
                                            height: 400,
                                            child: SingleChildScrollView(
                                              child: Text(
                                                  Static_Content.term_of_use),
                                            ),
                                          ));
                                    }));
                              },
                              child: const Text(
                                "使用條款",
                                style: TextStyle(
                                    color: StyleColor.darkBlue, fontSize: 15),
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
                                print(_isLoginSuccessful);
                                if (_isAcctValid && _isPwdValid) {
                                  Auth _auth = Auth();
                                  bool _result =
                                      await _auth.LoginCheck(acct, pwd);
                                  if (_result) {
                                    setState(() {
                                      _isAcctValid = true;
                                      _isPwdValid = true;
                                      _isLoginSuccessful = true;
                                    });
                                    print("login successful");
                                  } else {
                                    setState(() {
                                      _isAcctValid = false;
                                      _isPwdValid = false;
                                      _isLoginSuccessful = false;
                                    });
                                    print("login fail");
                                    print(_isLoginSuccessful);
                                    print(_isAcctValid);
                                    print(_isPwdValid);
                                  }
                                }
                              },
                              child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "登入",
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
                          height: 20,
                        ),
                        Text("尚未擁有帳號?",
                            style: Theme.of(context).textTheme.bodySmall),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ));
                              },
                              child: const Text(
                                "註冊",
                                style: TextStyle(color: StyleColor.darkBlue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ));
  }
}
