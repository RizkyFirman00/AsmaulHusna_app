import 'package:flutter/material.dart';
import 'main.dart';  // Import the main.dart where MyApp is defined
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      // Navigate to the main app after the splash screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyApp()), // Navigate to MyApp widget
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ic_logo.png', height: 100, width: 100), // Use your splash screen image
            SizedBox(height: 20),
            Text(
              "Asmaul Husna",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff8ac6d1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
