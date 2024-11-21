import 'package:asmaul_husna/bookmark/bookmark_page.dart';
import 'package:asmaul_husna/home/home_page.dart';
import 'package:asmaul_husna/hijaiyah/hijaiyah_page.dart';
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
      home: SplashScreen(), // Start with the splash screen
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
        floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Color(0xffffb6b9)),
        cardTheme: const CardTheme(surfaceTintColor: Colors.white),
        dialogTheme: const DialogTheme(surfaceTintColor: Colors.white, backgroundColor: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff4caf50), // Green color for the app bar
          title: const Row(
            children: [
              Image(
                image: AssetImage('assets/images/ic_logo.png'),
                height: 50,
                width: 50,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Asmaul Husna",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
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
      unselectedLabelColor: Colors.black26,
      indicatorColor: Colors.white,
      tabs: const [
        Tab(
          text: "Home",
          icon: Icon(Icons.menu_book),
        ),
        Tab(
          text: "Hijaiyah",
          icon: Icon(Icons.settings),
        ),
        Tab(
          text: "Bookmark",
          icon: Icon(Icons.bookmarks_outlined),
        ),
      ],
    );
  }
}