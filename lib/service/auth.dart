import 'package:ws54_flutter_prac1/service/sharedPref.dart';
import 'package:ws54_flutter_prac1/service/sql_service.dart';

class Auth {
  Future<bool> loginCheck(String account, String password) async {
    List<UserData> users = await DB.getData();
    for (UserData user in users) {
      if (user.account == account && user.password == password) {
        PreferencesManager().setLoginState(true);
        return true;
      }
    }
    PreferencesManager().setLoginState(false);
    return false;
  }

  Future<bool> isAccountRegistered(String account) async {
    List<UserData> users = await DB.getData();
    for (UserData user in users) {
      if (user.account == account) {
        return true;
      }
    }
    return false;
  }

  bool checkIsEmpty(String string) {
    return string.trim().isEmpty;
  }
}
