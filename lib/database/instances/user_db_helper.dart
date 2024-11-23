import 'package:asmaul_husna/model/model_user.dart';
import 'package:hive/hive.dart';

class UserDbHelper {
  static const String _boxName = 'userBox';

  // Singleton pattern
  static final UserDbHelper _instance = UserDbHelper._internal();

  factory UserDbHelper() => _instance;

  UserDbHelper._internal();

  // Membuka atau membuat box Hive
  Future<Box<ModelUser>> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<ModelUser>(_boxName);
    }
    return Hive.box<ModelUser>(_boxName);
  }

  // Registrasi user
  Future<bool> registerUser(ModelUser user) async {
    try {
      final box = await _getBox();
      final key = user.email!;
      await box.put(key, user);
      return true;
    } catch (e) {
      print('Error registering user: $e');
      return false;
    }
  }

  // Login user
  Future<bool> loginUser(String username, String password) async {
    final box = await _getBox();
    return box.values.any(
          (user) => user.username == username && user.password == password,
    );
  }

  // Mendapatkan user berdasarkan username
  Future<ModelUser?> getUserByUsername(String username) async {
    final box = await _getBox();
    final user = box.values.cast<ModelUser?>().firstWhere(
          (user) => user?.username == username,
      orElse: () => null,
    );
    return user;
  }

  // Mendapatkan semua user
  Future<List<ModelUser>> getAllUsers() async {
    final box = await _getBox();
    return box.values.toList();
  }

  // Update user
  Future<void> updateUser(ModelUser user) async {
    final box = await _getBox();
    await box.put(user.id, user); // Gunakan ID sebagai key untuk update
  }

  // Menghapus user
  Future<void> deleteUser(int id) async {
    final box = await _getBox();
    await box.delete(id);
  }
}
