import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        elevation: 0, // Tidak ada bayangan pada AppBar
        backgroundColor: Color(0xff4caf50), // Warna AppBar sesuai dengan tema
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
                    margin: EdgeInsets.only(bottom: 60),
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
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color(0xff4caf50), width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color(0xff4caf50), width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color(0xff4caf50), width: 2),
                          ),
                          labelText: "Username",
                          labelStyle: TextStyle(
                            color: Color(0xff4caf50)
                          )
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xff4caf50), width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xff4caf50), width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xff4caf50), width: 2),
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                                color: Color(0xff4caf50)
                            )
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {},
                            child: Text("Register"),
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.white),
                                foregroundColor:
                                    WidgetStatePropertyAll(Color(0xff4caf50))),
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {},
                            child: Text("Login"),
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Color(0xff4caf50)),
                              foregroundColor:
                                  WidgetStatePropertyAll(Colors.white),
                            ),
                          ))
                        ],
                      )
                    ],
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
}
