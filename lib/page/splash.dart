import 'package:flutter/material.dart';
import 'package:ws54_flutter_prac1/page/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _delayNavToHome() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()));
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
