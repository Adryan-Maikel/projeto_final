import 'connection.dart';
import 'package:sqflite/sqflite.dart';

class WinsDao {
  static const String _table = "wins";

  static Future<int> insert(Map<String, dynamic> map) async {
    Database database = await Connection.getConnection();
    int result = await database.insert(_table, map);
    return result;
  }
}