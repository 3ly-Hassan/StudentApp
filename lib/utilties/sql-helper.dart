import 'dart:io';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path_provider/path_provider.dart' as path;
import 'package:sqflite/utils/utils.dart';

class SqlHelper {
  static Future<sql.Database> database() async {
    Directory directory = await path.getApplicationDocumentsDirectory();
    String dbPath = directory.path + 'student.dp';
    final stDb = await sql.openDatabase(
      dbPath,
      version: 1,
      onCreate: (sql.Database db, int version) {
        return db.execute(
            'CREATE TABLE student_data(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, pass INTEGER, subject TEXT)');
      },
    );
    return stDb;
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqldb = await SqlHelper.database();
    await sqldb.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> update(
      String table, Map<String, Object> data, int id) async {
    final sqldb = await SqlHelper.database();
    await sqldb.update(table, data,
        where: 'id = ?',
        whereArgs: [id],
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> remove(String table, int id) async {
    final sqldb = await SqlHelper.database();
    await sqldb.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> removeAll(String table) async {
    final sqldb = await SqlHelper.database();
    await sqldb.delete(
      table,
    );
  }

  static Future<int> count(String table) async {
    final sqldb = await SqlHelper.database();
    List<Map<String, dynamic>> raw =
        await sqldb.rawQuery('SELECT COUNT(*) FROM student_data');
    int result = firstIntValue(raw);
    return result;
  }

  static Future<List<Map<String, dynamic>>> fetchData(String table) async {
    final sqldb = await SqlHelper.database();
    return await sqldb.query(table, orderBy: 'id ASC');
  }
}
