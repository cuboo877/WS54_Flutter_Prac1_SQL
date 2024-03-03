import 'package:flutter/material.dart';
import 'package:ws54_flutter_prac1/page/home.dart';
import 'package:ws54_flutter_prac1/page/login.dart';
import 'package:ws54_flutter_prac1/service/sharedPref.dart';
import 'package:ws54_flutter_prac1/widget/showSnackBar.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _delayNavToLogin() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  void _delayNavToHome() async {
    if (await PreferencesManager().isLogged()) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
        showSnackBar(context);
      }
    } else {
      _delayNavToLogin();
    }
  }

  @override
  void initState() {
    super.initState();
    _delayNavToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        "assets/icon.png",
        width: 200,
        height: 200,
      ),
    );
  }
}
