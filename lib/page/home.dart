import 'package:flutter/material.dart';
import 'package:ws54_flutter_prac1/constant/color_style.dart';
import 'package:ws54_flutter_prac1/page/login.dart';
import 'package:ws54_flutter_prac1/page/account.dart';
import 'package:ws54_flutter_prac1/service/sql_service.dart';
import 'package:ws54_flutter_prac1/widget/ShowSnackBar.dart';
import 'package:ws54_flutter_prac1/widget/homeAppBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: HomeAppBar(context)),
        drawer: Drawer(
            child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              _scaffoldKey.currentState?.closeDrawer();
                            },
                            icon: const Icon(
                              Icons.cancel,
                              size: 23,
                            )),
                        Image.asset(
                          "assets/icon.png",
                          width: 23,
                          height: 23,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  )),
              _bulidDrawerItem(
                  context, const Icon(Icons.home), "主畫面", const HomePage()),
              ListTile(
                onTap: () async {
                  UserData ud = await DB.getUserDataByActivity();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => AccountPage(ud: ud)));
                },
                leading: const Icon(Icons.person),
                title: const Text(
                  "帳號",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
              _buildLogOut(context)
            ],
          ),
        )),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const []),
        ));
  }
}

Widget _buildLogOut(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
          width: double.infinity,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  alignment: Alignment.center,
                  side: const BorderSide(width: 1.2, color: StyleColor.red),
                  backgroundColor: StyleColor.white),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
                showCustomSnackBar(context, "已登出帳號", const Duration(seconds: 1),
                    Duration.zero);
              },
              child: const Text("登出",
                  style: TextStyle(color: StyleColor.red, fontSize: 23)))));
}

Widget _bulidDrawerItem(
    BuildContext context, icon, String title, Widget navTarget) {
  return ListTile(
    onTap: () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => navTarget));
    },
    leading: icon,
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.normal),
    ),
  );
}

class _buildPasswordRow extends StatelessWidget {
  const _buildPasswordRow({required this.application, required this.password});
  final String password;
  final String application;
  @override
  Widget build(BuildContext context) {
    return Row();
  }
}
