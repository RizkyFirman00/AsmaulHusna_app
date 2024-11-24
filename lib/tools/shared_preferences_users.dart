import 'package:shared_preferences/shared_preferences.dart';
import 'package:asmaul_husna/model/model_user.dart';

class SharedPreferencesUsers {
  static const String _keyUserId = 'userId';
  static const String _keyUsername = 'username';
  static const String _keyEmail = 'email';
  static const String _keyPhoneNumber = 'phoneNumber';
  static const String _keyPassword = 'password';
  static const String _keyIsLoggedIn = 'isLoggedIn';

  // Simpan data login pengguna
  static Future<void> saveLoginData(ModelUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUserId, user.id!);
    await prefs.setString(_keyUsername, user.username!);
    await prefs.setString(_keyEmail, user.email!);
    await prefs.setString(_keyPhoneNumber, user.phoneNumber!);
    await prefs.setString(_keyPassword, user.password!);
    await prefs.setBool(_keyIsLoggedIn, true);
  }

  // Ambil data user
  static Future<ModelUser?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt(_keyUserId);
    String? username = prefs.getString(_keyUsername);
    String? email = prefs.getString(_keyEmail);
    String? phoneNumber = prefs.getString(_keyPhoneNumber);
    String? password = prefs.getString(_keyPassword);

    if (id != null &&
        username != null &&
        email != null &&
        phoneNumber != null &&
        password != null) {
      return ModelUser(
        id: id,
        username: username,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
      );
    } else if (username == "admin" && password == "password") {
      return ModelUser(
        id: id,
        username: username,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
      );
    }
    return null;
  }

  // Cek apakah user sudah login
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // Hapus data login (logout)
  static Future<void> clearLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyPhoneNumber);
    await prefs.remove(_keyPassword);
    await prefs.remove(_keyIsLoggedIn);
  }

  // Set username
  static Future<void> setUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
  }

  // Set password
  static Future<void> setPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPassword, password);
  }

  // Cek apakah user sudah login
  static Future<bool> setLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_keyIsLoggedIn, true);
  }
}
