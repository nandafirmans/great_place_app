import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static const DB_NAME = 'places.db';
  static const TB_NAME_PLACES = 'places';

  static Future<sql.Database> _getDbContext() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath, DB_NAME),
      version: 1,
      onCreate: (db, version) => db.execute(
        'CREATE TABLE $TB_NAME_PLACES(id TEXT PRIMARY KEY, title TEXT, image TEXT, location_lat REAL, location_lng REAL, address TEXT)',
      ),
    );
  }

  static Future<void> insert(String tableName, Map<String, Object> data) async {
    final dbContext = await _getDbContext();
    dbContext.insert(
      tableName,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final dbContext = await _getDbContext();
    return dbContext.query(table);
  }
}
