import 'package:asmaul_husna/model/model_user.dart';
import 'package:asmaul_husna/tools/shared_preferences_users.dart';
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
      int newId = 1;
      if (box.isNotEmpty) {
        final maxId = box.values
            .map((user) => user.id ?? 0)
            .reduce((max, id) => id > max ? id : max);
        newId = maxId + 1;
      }
      user.id = newId;
      await box.put(newId, user);
      return true;
    } catch (e) {
      print('Error registering user: $e');
      return false;
    }
  }

  // Login user
  Future<bool> loginUser(String username, String password) async {
    final box = await _getBox();
    final user = box.values.cast<ModelUser?>().firstWhere(
          (user) => user?.username == username && user?.password == password,
      orElse: () => null,
    );

    if (user != null) {
      ModelUser _user = ModelUser(
        id: user.id,
        email: user.email,
        phoneNumber: user.phoneNumber,
        username: user.username,
        password: user.password
      );
      await SharedPreferencesUsers.isLoggedIn();
      await SharedPreferencesUsers.saveLoginData(_user);
      return true;
    }
    return false;
  }

  // Cek apakah user sudah login sebelumnya
  Future<bool> isLoggedIn() async {
    return await SharedPreferencesUsers.isLoggedIn();
  }

  // Mendapatkan user berdasarkan id
  Future<ModelUser?> getUserById(int userId) async {
    final box = await _getBox();
    final user = box.values.cast<ModelUser?>().firstWhere(
          (user) => user?.id == userId,
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
    await box.put(user.id, user);
  }

  // Menambahkan atau memperbarui bookmark number untuk user
  Future<void> updateBookmarkForUser(int userId, int newBookmarkNumber) async {
    final box = await _getBox();
    final user = box.get(userId);

    if (user != null) {
      user.bookmark_number ??= [];

      if (!user.bookmark_number!.contains(newBookmarkNumber)) {
        user.bookmark_number!.add(newBookmarkNumber);
        await user.save();
        print('Bookmark $newBookmarkNumber berhasil ditambahkan ke user dengan ID $userId.');
      } else {
        print('Bookmark $newBookmarkNumber sudah ada untuk user dengan ID $userId.');
      }
    } else {
      print('User dengan ID $userId tidak ditemukan.');
    }
  }


  // Delete number bookmark di user
  Future<void> deleteBookmarkFromUser(int userId, int bookmarkNumber) async {
    final box = await _getBox();
    final user = box.get(userId);

    if (user != null) {
      user.bookmark_number?.remove(bookmarkNumber);
      await user.save();
    } else {
      print('User dengan ID $userId tidak ditemukan.');
    }
  }

  // Menghapus user
  Future<void> deleteUser(int id) async {
    final box = await _getBox();
    await box.delete(id);
  }

  // Logout user
  Future<void> logoutUser() async {
    await SharedPreferencesUsers.clearLoginData();
  }
}
