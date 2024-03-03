import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static Database? user_database;

  static Future<Database> initDatabase() async {
    user_database = await openDatabase(join(await getDatabasesPath(), "ws.db"),
        onCreate: (db, version) async {
      return db.execute(
          "CREATE TABLE test (id TEXT PRIMARY KEY, username TEXT, birthday TEXT,account TEXT, password TEXT, activity Int)");
    }, version: 1);
    return user_database!;
  }

  static Future<Database> getDBConnect() async {
    if (user_database != null) {
      return user_database!;
    }
    return await initDatabase();
  }

  static Future<List<UserData>> getData() async {
    final Database db = await getDBConnect();
    final List<Map<String, dynamic>> maps = await db.query("test");
    return List.generate(maps.length, (index) {
      return UserData(
          id: maps[index]["id"],
          username: maps[index]["username"],
          birthday: maps[index]["birthday"],
          account: maps[index]["account"],
          password: maps[index]["password"],
          activity: maps[index]["activity"]);
    });
  }

  static Future<UserData> getUserDataByActivity() async {
    final Database db = await getDBConnect();
    final List<Map<String, dynamic>> maps =
        await db.query("test", where: "activity = ?", whereArgs: [1]);
    Map<String, dynamic> ud = maps.first;
    return UserData(
        id: ud["id"],
        username: ud["username"],
        birthday: ud["birthday"],
        account: ud["account"],
        password: ud["password"],
        activity: ud["activity"]);
  }

  static Future<UserData> getUserDataByAccount(String account) async {
    final Database db = await getDBConnect();
    final List<Map<String, dynamic>> maps =
        await db.query("test", where: "account = ?", whereArgs: [account]);
    Map<String, dynamic> ud = maps.first;
    return UserData(
        id: ud["id"],
        username: ud["username"],
        birthday: ud["birthday"],
        account: ud["account"],
        password: ud["password"],
        activity: ud["activity"]);
  }

  static Future<void> addUser(UserData ud) async {
    final Database db = await getDBConnect();
    await db.insert("test", ud.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> updateUser(UserData ud) async {
    final Database db = await getDBConnect();
    await db.update("test", ud.toMap(), where: "id = ?", whereArgs: [ud.id]);
  }

  static Future<void> setUserActivity(UserData ud, int activity) async {
    final Database db = await getDBConnect();
    await db.update("test", ud.toMap(),
        where: "activity = ?", whereArgs: [activity]);
  }

  static Future<void> deleteUser(String id) async {
    final Database db = await getDBConnect();
    await db.delete("test", where: "id = ?", whereArgs: [id]);
  }
}

class UserData {
  final String id;
  late String username;
  late String birthday;
  late String account;
  late String password;
  late int activity;
  UserData(
      {required this.id,
      required this.username,
      required this.birthday,
      required this.account,
      required this.password,
      required this.activity});
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "username": username,
      "birthday": birthday,
      "account": account,
      "password": password,
      "activity": activity,
    };
  }
}

// --------------------------
class PasswordData {
  final String id;
  final String userid;
  final String name;
  final String url;
  final String login;
  final String password;
  PasswordData(
      this.id, this.userid, this.name, this.url, this.login, this.password);
}
