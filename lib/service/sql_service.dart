import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static Database? database;

  static Future<Database> initDatabase() async {
    database = await openDatabase(join(await getDatabasesPath(), "ws.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE users(id TEXT PRIMARY KEY, username TEXT, account TEXT, password TEXT)");
    }, version: 1);
    return database!;
  }

  static Future<Database> getDBConnect() async {
    if (database != null) {
      return database!;
    }
    return await initDatabase();
  }

  static Future<List<UserData>> getData() async {
    final Database db = await getDBConnect();
    final List<Map<String, dynamic>> maps = await db.query("users");
    return List.generate(maps.length, (index) {
      return UserData(
          id: maps[index]["id"],
          username: maps[index]["username"],
          account: maps[index]["account"],
          password: maps[index]["password"]);
    });
  }

  static Future<void> addUser(UserData ud) async {
    final Database db = await getDBConnect();
    await db.insert("users", ud.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> updateUser(UserData ud) async {
    final Database db = await getDBConnect();
    await db.update("users", ud.toMap(), where: "id = ?", whereArgs: [ud.id]);
  }

  static Future<void> deleteUser(String id) async {
    final Database db = await getDBConnect();
    await db.delete("users", where: "id = ?", whereArgs: [id]);
  }
}

class UserData {
  final String id;
  final String username;
  final String account;
  final String password;
  UserData(
      {required this.id,
      required this.username,
      required this.account,
      required this.password});
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": username,
      "account": account,
      "password": password,
    };
  }
}

class PasswordData {
  final String id;
  final String userid;
  final String password;
  PasswordData(this.id, this.userid, this.password);
}
