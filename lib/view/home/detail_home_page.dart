import 'package:asmaul_husna/database/instances/user_db_helper.dart';
import 'package:asmaul_husna/model/model_bookmark.dart';
import 'package:asmaul_husna/database/instances/bookmark_db_helper.dart';
import 'package:asmaul_husna/tools/shared_preferences_users.dart';
import 'package:flutter/material.dart';

import '../../model/model_user.dart';

class DetailHomePage extends StatefulWidget {
  final String strMeaning, strName, strTranslate, strKeterangan, strAmalan;
  final int strNo;

  const DetailHomePage(
      {super.key,
      required this.strMeaning,
      required this.strName,
      required this.strTranslate,
      required this.strKeterangan,
      required this.strAmalan,
      required this.strNo});

  @override
  State<DetailHomePage> createState() => _DetailHomePageState();
}

class _DetailHomePageState extends State<DetailHomePage> {
  bool isFlagged = false;
  List<ModelBookmark> listBookmark = [];
  BookmarkDbHelper bookmarkDatabaseHelper = BookmarkDbHelper();
  UserDbHelper userDatabaseHelper = UserDbHelper();
  late int strNo;
  String? strMeaning, strName, strTranslate, strKeterangan, strAmalan;

  @override
  initState() {
    super.initState();
    _checkFlag();
    strNo = widget.strNo;
    strMeaning = widget.strMeaning;
    strName = widget.strName;
    strTranslate = widget.strTranslate;
    strKeterangan = widget.strKeterangan;
    strAmalan = widget.strAmalan;
  }

  Future<void> _checkFlag() async {
    final int? userId = await SharedPreferencesUsers.getUserId();
    final ModelUser? user = await userDatabaseHelper.getUserById(userId!);
    final List<int>? bookmarkUser = user?.bookmark_number;
    bool alreadyBookmarked = (bookmarkUser ?? []).contains(strNo);
    setState(() {
      isFlagged = alreadyBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: const Color(0xff4caf50),
              expandedHeight: 250,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  strTranslate!,
                  style: const TextStyle(fontSize: 20),
                ),
                titlePadding: const EdgeInsets.only(left: 52.0, bottom: 16.0),
                background: Image.asset(
                  'assets/images/banner.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    strName!,
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    strTranslate!,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  strKeterangan!,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  strAmalan!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffFF4caf50),
        onPressed: () async {
          bool isTapped = false;
          if (!isTapped) {
            isTapped = true;
            final int? userId = await SharedPreferencesUsers.getUserId();
            final ModelUser? user = await userDatabaseHelper.getUserById(userId!);
            final List<int>? bookmarkUser = user?.bookmark_number;

            if (bookmarkUser == null) {
              print("User has no bookmarks.");
            }
            bool alreadyBookmarked = (bookmarkUser ?? []).contains(strNo);
            print("ALREADYBOOKMARKED: $alreadyBookmarked");

            setState(() {
              isFlagged = alreadyBookmarked;
            });

            if (!isFlagged) {
              await userDatabaseHelper.updateBookmarkForUser(userId, strNo);
              await bookmarkDatabaseHelper.saveData(
                ModelBookmark(
                  number: strNo,
                  name: strName,
                  transliteration: strTranslate,
                  meaning: strMeaning,
                  keterangan: strKeterangan,
                  amalan: strAmalan,
                  flag: 'Y',
                ),
              );
            } else {
              await userDatabaseHelper.deleteBookmarkFromUser(userId, strNo);
            }
            Navigator.pop(context);
            isTapped = false;
          }
        },
        child: Icon(
          Icons.star_rounded,
          size: 38,
          color: isFlagged ? Colors.yellow : Colors.white,
        ),
      ),

    );
  }
}
