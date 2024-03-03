import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  Future<void> setLoginState(bool isLogged) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogged", isLogged);
  }

  Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogged") ?? false;
  }
}
