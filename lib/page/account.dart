import 'package:flutter/material.dart';
import 'package:ws54_flutter_prac1/constant/color_style.dart';
import 'package:ws54_flutter_prac1/page/home.dart';
import 'package:ws54_flutter_prac1/page/login.dart';
import 'package:ws54_flutter_prac1/service/auth.dart';
import 'package:ws54_flutter_prac1/service/sharedPref.dart';
import 'package:ws54_flutter_prac1/service/sql_service.dart';
import 'package:ws54_flutter_prac1/widget/ShowSnackBar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key, required this.ud});
  final UserData ud;

  @override
  State<StatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("帳號管理"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: StyleColor.darkBlue,
                borderRadius: const BorderRadius.all(Radius.circular(45))),
            alignment: Alignment.center,
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              _dataRow(title: "用戶名稱", content: widget.ud.username),
              const SizedBox(
                height: 20,
              ),
              _dataRow(title: "帳號", content: widget.ud.account),
              const SizedBox(
                height: 20,
              ),
              _dataRow(title: "密碼", content: widget.ud.password),
              const SizedBox(
                height: 20,
              ),
              _dataRow(title: "生日", content: widget.ud.birthday),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          logOutButton(context),
        ]),
      ),
    );
  }
}

Widget logOutButton(BuildContext context) {
  return SizedBox(
      height: 55,
      width: double.infinity,
      child: OutlinedButton(
          onPressed: () async {
            await PreferencesManager().setLoginState(false);
            await DB.setUserActivity(await DB.getUserDataByActivity(), 0);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()));
            showCustomSnackBar(
                context, "已登出", const Duration(seconds: 2), Duration.zero);
          },
          style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 1, color: StyleColor.red),
              alignment: Alignment.center,
              backgroundColor: StyleColor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45),
              )),
          child: const Text(
            "登出",
            style: TextStyle(
              color: StyleColor.red,
              fontSize: 23,
            ),
          )));
}

// --------------------------------------------------
class _dataRow extends StatefulWidget {
  _dataRow({required this.title, required this.content});

  final String title;
  String content;
  @override
  State<StatefulWidget> createState() => _dataRowState();
}

class _dataRowState extends State<_dataRow> {
  TextEditingController editedContentConrtoller = TextEditingController();
  @override
  void initState() {
    super.initState();
    editedContentConrtoller = TextEditingController();
  }

  @override
  void dispose() {
    editedContentConrtoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(color: StyleColor.white, fontSize: 23),
        ),
        const SizedBox(
          width: 30,
        ),
        Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            alignment: Alignment.centerLeft,
            width: 380,
            decoration: BoxDecoration(
                color: StyleColor.white,
                borderRadius: BorderRadius.circular(45)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.content,
                  style:
                      const TextStyle(color: StyleColor.darkBlue, fontSize: 23),
                ),
                IconButton(
                    iconSize: 23,
                    onPressed: () async {
                      if (widget.title == "生日") {
                        if (widget.title == "生日") {
                          DateTime? _picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100));
                          if (_picked != null) {
                            setState(() {
                              widget.content = _picked.toString().split(" ")[0];
                            });
                          } else {}
                          UserData newUd = await DB.getUserDataByActivity();
                          newUd.birthday = widget.content;
                          await DB.updateUser(newUd);
                        }
                      } else {
                        showDialog(
                            context: (context),
                            builder: (context) {
                              return AlertDialog(
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      UserData newUd =
                                          await DB.getUserDataByActivity();
                                      if (widget.title == "用戶名稱") {
                                        newUd.username =
                                            editedContentConrtoller.text;
                                        await DB.updateUser(newUd);
                                      } else if (widget.title == "帳號") {
                                        newUd.account =
                                            editedContentConrtoller.text;
                                        await DB.updateUser(newUd);
                                      } else if (widget.title == "生日") {
                                        newUd.birthday =
                                            editedContentConrtoller.text;
                                        await DB.updateUser(newUd);
                                      } else if (widget.title == "密碼") {
                                        newUd.password =
                                            editedContentConrtoller.text;
                                        await DB.updateUser(newUd);
                                      }
                                      setState(() {
                                        widget.content =
                                            editedContentConrtoller.text;
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    style: ButtonStyle(
                                        alignment: Alignment.center,
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                StyleColor.darkBlue)),
                                    child: const Text(
                                      "完成",
                                      style: TextStyle(
                                          color: StyleColor.white,
                                          fontSize: 23),
                                    ),
                                  )
                                ],
                                backgroundColor: StyleColor.white,
                                title: Text("編輯${widget.title}"),
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 320,
                                        child: TextFormField(
                                          controller: editedContentConrtoller,
                                          autofocus: true,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (widget.title == "帳戶") {
                                              if (value == null) {
                                                return null;
                                              } else if (value == "") {
                                                // 是否沒輸入東西
                                                //doLoginDataValidWarning = false;
                                                return "請輸入帳號";
                                              } else if (!value
                                                  .endsWith("@gmail.com")) {
                                                //是否為Gmail格式
                                                return "錯誤的帳號格式";
                                              } else if (value ==
                                                  "@gmail.com") {
                                                // 是否只是"@gmail.com"
                                                return "請輸入正確的帳號";
                                              } else {
                                                // 正確格式
                                                return null;
                                              }
                                            } else if (widget.title == "用戶名稱") {
                                              Auth auth = Auth();
                                              if (value == "" ||
                                                  value == null ||
                                                  value.isEmpty) {
                                                return "請輸入稱呼您的名稱";
                                              } else if (auth
                                                  .checkIsEmpty(value)) {
                                                return "請輸入稱呼您的名稱";
                                              }
                                              return null;
                                            } else if (widget.title == "密碼") {
                                              Auth auth = Auth();
                                              if (value == "" ||
                                                  value == null ||
                                                  value.isEmpty) {
                                                return "請輸入正確的密碼格式";
                                              } else if (auth
                                                  .checkIsEmpty(value)) {
                                                return "請輸入正確的密碼格式";
                                              }
                                              return null;
                                            }
                                            return null;
                                          },
                                        ),
                                      )
                                    ]),
                              );
                            });
                      }
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: StyleColor.darkBlue,
                    ))
              ],
            ))
      ],
    );
  }
}
