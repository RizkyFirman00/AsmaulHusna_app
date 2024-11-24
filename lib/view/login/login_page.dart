import 'package:asmaul_husna/database/instances/user_db_helper.dart';
import 'package:asmaul_husna/main.dart';
import 'package:asmaul_husna/view/admin/admin_home_page.dart';
import 'package:asmaul_husna/view/register/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserDbHelper _userDbHelper = UserDbHelper();

  final _formKey = GlobalKey<FormState>();

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username == "admin" && password == "password") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AdminHomePage()));
    } else {
      var result = await _userDbHelper.loginUser(username, password);

      if (result) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MyApp()));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Selamat Datang $username')));
      } else {
        _usernameController.text = "";
        _passwordController.text = "";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username atau Password salah')),
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
        backgroundColor: const Color(0xff4caf50),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    margin: const EdgeInsets.only(bottom: 50),
                    decoration: const BoxDecoration(
                      color: Color(0xff4caf50),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(200),
                      ),
                    ),
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
                              style: const TextStyle(
                                fontSize: 78,
                                wordSpacing: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Positioned(
                              top: 75,
                              child: Text(
                                isKeyboardOpen ? "" : "HUSNA",
                                style: const TextStyle(
                                  fontSize: 64,
                                  wordSpacing: 2,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            decoration: _inputDecoration("Username"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Username tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
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
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: const Text("Register"),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    foregroundColor: MaterialStateProperty.all(
                                      const Color(0xff4caf50),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => _loginUser(),
                                  child: const Text("Login"),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff4caf50)),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
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
