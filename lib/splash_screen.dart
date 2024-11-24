import 'package:asmaul_husna/database/instances/user_db_helper.dart';
import 'package:asmaul_husna/main.dart';
import 'package:asmaul_husna/model/model_user.dart';
import 'package:asmaul_husna/tools/shared_preferences_users.dart';
import 'package:asmaul_husna/view/admin/admin_home_page.dart';
import 'package:asmaul_husna/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await SharedPreferencesUsers.isLoggedIn();
    ModelUser? user = await SharedPreferencesUsers.getUser();

    Timer(const Duration(seconds: 3), () {
      if (isLoggedIn && user != null) {
        String? username = user.username;
        String? password = user.password;
        if (username == 'admin' && password == 'password') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AdminHomePage()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyApp()),
          );
        }
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }


  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ic_logo.png', height: 100, width: 100),
            const SizedBox(height: 20),
            const Text(
              "Asmaul Husna",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
