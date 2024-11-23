import 'package:asmaul_husna/database/instances/user_db_helper.dart';
import 'package:asmaul_husna/model/model_user.dart';
import 'package:asmaul_husna/view/login/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final UserDbHelper _userDbHelper = UserDbHelper();

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    ModelUser modelUser = ModelUser(
        email: email,
        phoneNumber: phone,
        username: username,
        password: password);

    if (email.isEmpty ||
        phone.isEmpty ||
        username.isEmpty ||
        password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tolong isi semua data")),
      );
      return;
    }

    if (email.isNotEmpty &&
        phone.isNotEmpty &&
        username.isNotEmpty &&
        password.isNotEmpty) {
      var result = await _userDbHelper.registerUser(modelUser);

      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Berhasil!")),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration Gagal!")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        elevation: 0,
        backgroundColor: Color(0xff4caf50),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    margin: EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                        color: Color(0xff4caf50),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(200))),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: isKeyboardOpen ? 0 : 150,
                          width: isKeyboardOpen ? 0 : 150,
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Text(
                              isKeyboardOpen ? "" : "ASMAUL",
                              style: TextStyle(
                                  fontSize: 78,
                                  wordSpacing: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Positioned(
                              top: 75,
                              child: Text(
                                isKeyboardOpen ? "" : "HUSNA",
                                style: TextStyle(
                                    fontSize: 64,
                                    wordSpacing: 2,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextFormField(
                              controller: _emailController,
                              decoration: _inputDecoration("Email"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password tidak boleh kosong";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _phoneController,
                              decoration: _inputDecoration("Phone Number"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password tidak boleh kosong";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _usernameController,
                              decoration: _inputDecoration("Username"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password tidak boleh kosong";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              decoration: _inputDecoration("Password"),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password tidak boleh kosong";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _registerUser();
                                    },
                                    child: Text("Register"),
                                    style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Color(0xff4caf50)),
                                        foregroundColor:
                                            WidgetStatePropertyAll(Colors.white)),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  },
                                  child: Text("Login"),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.white),
                                    foregroundColor:
                                        WidgetStatePropertyAll(Color(0xff4caf50)),
                                  ),
                                ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 150,
              width: 150,
              child: Image.asset(
                "assets/images/ic_logo.png",
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
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
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xff4caf50)),
    );
  }
}
