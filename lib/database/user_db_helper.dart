import 'package:asmaul_husna/model/model_user.dart';
import 'package:sqflite/sqflite.dart';
import 'base_db_helper.dart';

class UserDbHelper extends BaseDbHelper {
  static final UserDbHelper instance = UserDbHelper._internal();

  static const String columnId = 'id';
  static const String columnEmail = 'email';
  static const String columnPhoneNumber = 'phone_number';
  static const String columnUsername = 'username';
  static const String columnPassword = 'password';

  UserDbHelper._internal() : super('tbl_user');

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY,
        $columnEmail TEXT NOT NULL UNIQUE,
        $columnPhoneNumber TEXT,
        $columnUsername TEXT NOT NULL,
        $columnPassword TEXT NOT NULL
      )
    ''');
  }

  Future<bool> registerUser(ModelUser user) async {
    try {
      final db = await database;

      final existingUser = await db.query(
        tableName,
        where: '$columnEmail = ?',
        whereArgs: [user.email],
      );

      if (existingUser.isNotEmpty) {
        return false;
      }

      await db.insert(tableName, user.toMap());
      return true;
    } catch (e) {
      print('Error registering user: ${e.toString()}');
      return false;
    }
  }

  // Login user
  Future<bool> loginUser(String username, String password) async {
    try {
      final db = await database;
      final result = await db.query(
        tableName,
        where: '$columnUsername = ? AND $columnPassword = ?',
        whereArgs: [username, password],
      );

      return result.isNotEmpty;
    } catch (e) {
      print('Error logging in: ${e.toString()}');
      return false;
    }
  }

  // Get user data by username
  Future<ModelUser?> getUserByUsername(String username) async {
    try {
      final db = await database;
      final result = await db.query(
        tableName,
        where: '$columnUsername = ?',
        whereArgs: [username],
      );

      if (result.isNotEmpty) {
        return ModelUser.fromMap(result.first);
      }
      return null;
    } catch (e) {
      print('Error getting user: ${e.toString()}');
      return null;
    }
  }

  // Get all users
  Future<List<ModelUser>> getAllUsers() async {
    final db = await database;
    final results = await db.query(tableName);
    return results.map((map) => ModelUser.fromMap(map)).toList();
  }

  // Get user count
  Future<int> getUserCount() async {
    final db = await database;
    final result = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName')
    );
    return result ?? 0;
  }

  // Update user
  Future<bool> updateUser(ModelUser user) async {
    try {
      final db = await database;
      final rowsAffected = await db.update(
        tableName,
        user.toMap(),
        where: '$columnId = ?',
        whereArgs: [user.id],
      );
      return rowsAffected > 0;
    } catch (e) {
      print('Error updating user: ${e.toString()}');
      return false;
    }
  }

  // Delete user
  Future<bool> deleteUser(int id) async {
    try {
      final db = await database;
      final rowsAffected = await db.delete(
          tableName,
          where: '$columnId = ?',
          whereArgs: [id]
      );
      return rowsAffected > 0;
    } catch (e) {
      print('Error deleting user: ${e.toString()}');
      return false;
    }
  }
}