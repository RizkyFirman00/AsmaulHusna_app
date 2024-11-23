import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database_constants.dart';

abstract class BaseDbHelper {
  Database? _database;
  final String tableName;

  BaseDbHelper(this.tableName);

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, DatabaseConstants.dbName);

    return await openDatabase(
      path,
      version: DatabaseConstants.dbVersion,
      onCreate: onCreate,
    );
  }

  Future<void> onCreate(Database db, int version);

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}