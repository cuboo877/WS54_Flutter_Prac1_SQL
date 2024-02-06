import 'dart:math';

import 'package:ws54_flutter_prac1/service/sql_service.dart';

class Auth {
  Future<bool> LoginCheck(String account, String password) async {
    List<UserData> users = await DB.getData();
    for (UserData user in users) {
      if (user.account == account && user.password == password) {
        return true;
      }
    }
    return false;
  }

  Future<bool> RegisterEmailCheck(String account, String password) async {
    List<UserData> users = await DB.getData();
    for (UserData user in users) {
      if (user.account == account) {
        return true;
      }
    }
    return false;
  }
}

String _randomId() {
  var rd = new Random();
  String _result = "";
  for (var i = 0; i < 10; i++) {
    _result += rd.nextInt(10).toString();
  }
  return _result;
}
