import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async{
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'diary.db'),
        onCreate: (db, version) {
      print('db creato');
          return db.execute(
              'CREATE TABLE user_diary(id TEXT, title TEXT, body TEXT, date TEXT)');
        }, version: 2);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async{
    final db = await DBHelper.database();
    return db.query(table);
  }
}

