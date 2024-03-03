import 'package:flutter/material.dart';
import 'package:ws54_flutter_prac1/constant/color_style.dart';
import 'package:ws54_flutter_prac1/page/home.dart';
import 'package:ws54_flutter_prac1/service/auth.dart';
import 'package:ws54_flutter_prac1/service/random_generation.dart';
import 'package:ws54_flutter_prac1/service/sharedPref.dart';
import 'package:ws54_flutter_prac1/service/sql_service.dart';
import 'package:ws54_flutter_prac1/widget/ShowSnackBar.dart';

class UserDataSetupPage extends StatefulWidget {
  UserDataSetupPage({super.key, required this.account, required this.password});
  String account;
  String password;

  @override
  State<UserDataSetupPage> createState() => _UserDataSetupPageState();
}

class _UserDataSetupPageState extends State<UserDataSetupPage> {
  bool isUserNameValid = false;
  bool isBirthdayValid = false;
  bool isLoading = false;
  late TextEditingController username_controller;
  late TextEditingController birthday_controller;
  @override
  void initState() {
    super.initState();
    username_controller = TextEditingController();
    birthday_controller = TextEditingController();
  }

  @override
  void dispose() {
    username_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
        absorbing: isLoading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: StyleColor.darkBlue,
            title: const Text(
              "即將完成註冊",
              style: TextStyle(
                  color: StyleColor.white, fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: StyleColor.white,
              ),
              onPressed: (() {
                Navigator.of(context).pop();
              }),
            ),
          ),
          body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "請輸入使用者基本資料",
                  style: TextStyle(
                      color: StyleColor.darkBlue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
                SizedBox(
                  width: 320,
                  child: TextFormField(
                    controller: username_controller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      Auth auth = Auth();
                      if (value == "" || value == null || value.isEmpty) {
                        isUserNameValid = false;
                        return "請輸入稱呼您的名稱";
                      } else if (auth.checkIsEmpty(value)) {
                        isUserNameValid = false;
                        return "請輸入稱呼您的名稱";
                      }
                      isUserNameValid = true;
                      return null;
                    },
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                            color: StyleColor.lightgrey, Icons.person),
                        hintText: "User Name",
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
                    controller: birthday_controller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == "" || value == null) {
                        isBirthdayValid = false;
                        return "請輸入您的生日";
                      }
                      isBirthdayValid = true;
                      return null;
                    },
                    onTap: () async {
                      DateTime? _picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100));
                      if (_picked != null) {
                        birthday_controller.text =
                            _picked.toString().split(" ")[0];
                      } else {
                        isBirthdayValid = false;
                      }
                    },
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                            color: StyleColor.lightgrey, Icons.calendar_month),
                        hintText: "YYYY-MM-DD",
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
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("即將完成"),
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

                    await DB.addUser(UserData(
                        id: RandomGeneration().randomId().toString(),
                        username: username_controller.text,
                        birthday: birthday_controller.text,
                        account: widget.account,
                        password: widget.password,
                        activity: 1));
                    setState(() {
                      isLoading = false;
                      showSnackBar(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    });
                  },
                  child: Container(
                    // alignment: Alignment.center,
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                        color: StyleColor.darkBlue,
                        borderRadius: BorderRadius.circular(45)),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "開始",
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
                  ),
                )
              ]),
        ));
  }
}
