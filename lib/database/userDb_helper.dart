import 'package:asmaul_husna/model/model_user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tbl_user';
  final String columnId = 'id';
  final String columnEmail = 'email';
  final String columnPhoneNumber= 'phone_number';
  final String columnUsername = 'username';
  final String columnPassword = 'password';

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  //cek apakah ada database
  Future<Database?> get checkDB async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB();
    return _database;
  }

  Future<Database?> _initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'asmaulhusna.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnEmail TEXT,"
        "$columnPhoneNumber TEXT,"
        "$columnUsername TEXT,"
        "$columnPassword TEXT,";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveData(ModelUser modelUser) async {
    var dbClient = await checkDB;
    return await dbClient!.insert(tableName, modelUser.toMap());
  }

  //read data user
  Future<List?> getDataUser() async {
    var dbClient = await checkDB;
    var result = await dbClient!.rawQuery('SELECT * FROM $tableName ORDER BY number');
    return result.toList();
  }

  //cek database user
  Future<int?> cekDataUser() async {
    var dbClient = await checkDB;
    return Sqflite.firstIntValue(await dbClient!.
    rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  //update data user
  Future<int?> updateDataUser(ModelUser modelUser) async {
    var dbClient = await checkDB;
    return await dbClient!.update(
      tableName,
      modelUser.toMap(),
      where: '$columnId = ?',
      whereArgs: [modelUser.id],
    );
  }

  //hapus data user
  Future<int?> deleteBookmark(int id) async {
    var dbClient = await checkDB;
    return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  //login user
  Future<Map<String, dynamic>?> loginUser(String username, String password) async {
    var dbClient = await checkDB;
    var result = await dbClient!.query(
      tableName,
      where: '$columnUsername = ? AND $columnPassword = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  //register user
  Future<String> registerUser(ModelUser modelUser) async {
    var dbClient = await checkDB;
    var existingUser = await dbClient!.query(
      tableName,
      where: '$columnEmail = ?',
      whereArgs: [modelUser.email],
    );
    if (existingUser.isNotEmpty) {
      return 'Email already registered';
    }
    await dbClient.insert(tableName, modelUser.toMap());
    return 'Registration successful';
  }

}