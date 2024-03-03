import 'package:flutter/material.dart';
import 'package:ws54_flutter_prac1/constant/color_style.dart';
import 'package:ws54_flutter_prac1/constant/content.dart';
import 'package:ws54_flutter_prac1/page/home.dart';
import 'package:ws54_flutter_prac1/page/register.dart';
import 'package:ws54_flutter_prac1/service/auth.dart';
import 'package:ws54_flutter_prac1/service/sql_service.dart';
import 'package:ws54_flutter_prac1/widget/showSnackBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage(
      {super.key, this.registeredAccount = "", this.registeredPassword = ""});
  final String registeredAccount;
  final String registeredPassword;
  @override
  State<StatefulWidget> createState() => _StateLoginPage();
}

class _StateLoginPage extends State<LoginPage> {
  late TextEditingController account_controller;
  late TextEditingController password_controller;
  bool _obscure = true;

  void _toggle() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  bool isLoading = false;
  bool isAccountValid = false;
  bool isPasswordValid = false;
  bool doAuthFailWarning = false;

  @override
  void initState() {
    super.initState();
    account_controller = TextEditingController(text: widget.registeredAccount);
    password_controller =
        TextEditingController(text: widget.registeredPassword);
    if (account_controller.text != "") {
      isAccountValid = true;
    }
    if (password_controller.text != "") {
      isPasswordValid = true;
    }
  }

  @override
  void dispose() {
    account_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Scaffold(
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
                              onChanged: (value) {
                                doAuthFailWarning = false;
                              },
                              validator: (value) {
                                // 若按下登入後，格式卻是錯誤的
                                if (doAuthFailWarning == true) {
                                  return "";
                                }
                                //  是否輸入文字?
                                else if (value == null) {
                                  doAuthFailWarning = false;
                                  isAccountValid = false;
                                  return null;
                                } else if (value == "") {
                                  // 是否沒輸入東西
                                  //doLoginDataValidWarning = false;
                                  isAccountValid = false;
                                  return "請輸入帳號";
                                } else if (!value.endsWith("@gmail.com")) {
                                  //是否為Gmail格式
                                  doAuthFailWarning = false;
                                  isAccountValid = false;
                                  return "錯誤的帳號格式";
                                } else if (value == "@gmail.com") {
                                  // 是否只是"@gmail.com"
                                  doAuthFailWarning = false;
                                  isAccountValid = false;
                                  return "請輸入正確的帳號";
                                } else {
                                  // 正確格式
                                  doAuthFailWarning = false;
                                  isAccountValid = true;
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
                              obscureText: _obscure,
                              controller: password_controller,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.normal),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) {
                                doAuthFailWarning = false;
                              },
                              validator: (value) {
                                if (doAuthFailWarning == true) {
                                  isPasswordValid = false;
                                  return "錯誤的帳號或密碼";
                                } else if (value == null || value == "") {
                                  doAuthFailWarning = false;
                                  isPasswordValid = false;
                                  return "請輸入密碼";
                                }
                                doAuthFailWarning = false;
                                isPasswordValid = true;
                                return null;
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _toggle();
                                    },
                                    icon: Icon(
                                      _obscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
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
                                  String account = account_controller.text;
                                  String password = password_controller.text;
                                  bool isAuthCorrect = false;

                                  if (isAccountValid == true &&
                                      isPasswordValid == true) {
                                    setState(() {
                                      isLoading = true;
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              alignment: Alignment.center,
                                              title: Text("登入中"),
                                              content: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CircularProgressIndicator(),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text("Loading...")
                                                ],
                                              ),
                                            );
                                          });
                                    });
                                    doAuthFailWarning = false;
                                    Auth auth = Auth();
                                    isAuthCorrect = await auth.loginCheck(
                                        account, password);
                                    if (isAuthCorrect == true) {
                                      UserData ud =
                                          await DB.getUserDataByActivity();
                                      DB.setUserActivity(ud, 1);

                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  const HomePage())));
                                      showSnackBar(context);
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                        Navigator.of(context)
                                            .pop(); // alertdialog消除
                                      });
                                      doAuthFailWarning = true; //  登入失敗
                                    }
                                  } else {
                                    // 不做任何操作，保持顯示錯誤，並退出loading
                                  }
                                },
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
          )),
    );
  }
}
