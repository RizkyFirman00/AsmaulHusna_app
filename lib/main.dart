import 'package:asmaul_husna/view/bookmark/bookmark_page.dart';
import 'package:asmaul_husna/view/home/home_page.dart';
import 'package:asmaul_husna/view/hijaiyah/hijaiyah_page.dart';
import 'package:asmaul_husna/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the splash screen

void main() {
  runApp(MySplashApp());
}

class MySplashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this); // Updated to 3 tabs
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xffffb6b9)),
        cardTheme: const CardTheme(surfaceTintColor: Colors.white),
        dialogTheme: const DialogTheme(
            surfaceTintColor: Colors.white, backgroundColor: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/ic_logo.png",
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Asmaul Husna",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  icon: Icon(Icons.logout)),
            )
          ],
          backgroundColor: const Color(0xff4caf50),
          bottom: setTabBar(),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            HomePage(),
            HijaiyahPage(),
            BookmarkPage(),
          ],
        ),
      ),
    );
  }

  TabBar setTabBar() {
    return TabBar(
      controller: tabController,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white.withOpacity(0.3),
      indicatorColor: Colors.white,
      tabs: const [
        Tab(
          text: "Home",
          icon: Icon(Icons.library_books_rounded),
        ),
        Tab(
          text: "Hijaiyah",
          icon: Icon(Icons.text_fields_rounded),
        ),
        Tab(
          text: "Favorite",
          icon: Icon(Icons.star_rounded),
        ),
      ],
    );
  }
}
