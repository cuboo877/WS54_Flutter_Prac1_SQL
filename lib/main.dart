import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ws54_flutter_prac1/page/splash.dart';
import 'package:ws54_flutter_prac1/constant/color_style.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '5408 World Skill Password_Manager',
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: const TextTheme(
          bodySmall: TextStyle(
              color: StyleColor.black, fontSize: 16, fontFamily: "Averta"),
          bodyMedium: TextStyle(
              color: StyleColor.black, fontSize: 18, fontFamily: "Averta"),
          bodyLarge: TextStyle(
              color: StyleColor.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: "Averta"),
        ),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
