import 'package:sqflite/sqflite.dart';

class Connection {
  static Future<Database> getConnection() async {
    var sysPath = getDatabasesPath();
    var path = "$sysPath wins.db";
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, _) async {
        await database.execute(
          "create table wins(qntWins INT)"
        );
      },
    );
    return database;
  }
}
