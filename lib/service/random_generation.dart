import 'dart:math';

class RandomGeneration {
  String randomId() {
    var rd = Random();
    String result = "";
    for (var i = 0; i < 10; i++) {
      result += rd.nextInt(10).toString();
    }
    return result;
  }
}
