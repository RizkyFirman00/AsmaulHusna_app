import 'package:asmaul_husna/database/instances/user_db_helper.dart';
import 'package:asmaul_husna/view/admin/admin_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:asmaul_husna/model/model_user.dart';
import 'package:asmaul_husna/view/login/login_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late Future<List<ModelUser>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = UserDbHelper().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                "Admin Home Page",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<ModelUser>>(
          future: _usersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No users found.'));
            } else {
              final users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    onTap: () {
                      print("ID: ${users[index].id}");
                      int? idUser = users[index].id;
                      String emailUser = users[index].email.toString();
                      String phoneNumberUser =
                          users[index].phoneNumber.toString();
                      String usernameUser = users[index].username.toString();
                      String passwordUser = users[index].password.toString();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminDetailPage(
                            id: idUser!,
                            email: emailUser,
                            phoneNumber: phoneNumberUser,
                            username: usernameUser,
                            password: passwordUser,
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      child: Text(
                        user.username![0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    ),
                    title: Text(user.username ?? 'Unknown'),
                    subtitle: Text(user.email ?? 'No Email'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_rounded, color: Colors.red),
                      onPressed: () async {
                        await UserDbHelper().deleteUser(user.id!);
                        setState(() {
                          _usersFuture = UserDbHelper().getAllUsers();
                        });
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
