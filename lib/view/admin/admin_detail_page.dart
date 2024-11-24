import 'package:asmaul_husna/database/instances/user_db_helper.dart';
import 'package:asmaul_husna/model/model_user.dart';
import 'package:flutter/material.dart';

class AdminDetailPage extends StatelessWidget {
  final int id;
  final String email;
  final String phoneNumber;
  final String username;
  final String password;

  const AdminDetailPage({
    super.key,
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.username,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController =
        TextEditingController(text: email);
    final TextEditingController _phoneController =
        TextEditingController(text: phoneNumber);
    final TextEditingController _usernameController =
        TextEditingController(text: username);
    final TextEditingController _passwordController =
        TextEditingController(text: password);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff4caf50),
        title: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Image.asset(
                "assets/images/ic_logo.png",
                height: 25,
              ),
              const SizedBox(width: 10),
              const Text(
                "Admin Detail Page",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: _inputDecoration("Email"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _phoneController,
                  decoration: _inputDecoration("Phone Number"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _usernameController,
                  decoration: _inputDecoration("Username"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: _inputDecoration("Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      print("ID: $id");
                      print("Email: ${_emailController.text}");
                      print("Phone: ${_phoneController.text}");
                      print("Username: ${_usernameController.text}");
                      print("Password: ${_passwordController.text}");

                      final updatedUser = ModelUser(
                        id: id,
                        email: _emailController.text,
                        phoneNumber: _phoneController.text,
                        username: _usernameController.text,
                        password: _passwordController.text,
                      );

                      if (_emailController.text.isNotEmpty &&
                          _phoneController.text.isNotEmpty &&
                          _usernameController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        await UserDbHelper().updateUser(updatedUser);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("User updated successfully!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Failed to update user."),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4caf50),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xff4caf50), width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xff4caf50), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xff4caf50), width: 2),
      ),
      labelText: labelText,
      labelStyle: const TextStyle(color: Color(0xff4caf50)),
    );
  }
}
