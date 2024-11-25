import 'package:asmaul_husna/database/instances/user_db_helper.dart';
import 'package:asmaul_husna/model/model_bookmark.dart';
import 'package:asmaul_husna/database/instances/bookmark_db_helper.dart';
import 'package:asmaul_husna/tools/shared_preferences_users.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../model/model_user.dart';

class DetailHomePage extends StatefulWidget {
  final String strMeaning,
      strName,
      strTranslate,
      strKeterangan,
      strAmalan,
      strSound;
  final Color strColor;
  final int strNo;

  const DetailHomePage({
    super.key,
    required this.strMeaning,
    required this.strName,
    required this.strTranslate,
    required this.strKeterangan,
    required this.strAmalan,
    required this.strSound,
    required this.strNo,
    required this.strColor,
  });

  @override
  State<DetailHomePage> createState() => _DetailHomePageState();
}

class _DetailHomePageState extends State<DetailHomePage> {
  bool isFlagged = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<ModelBookmark> listBookmark = [];
  BookmarkDbHelper bookmarkDatabaseHelper = BookmarkDbHelper();
  UserDbHelper userDatabaseHelper = UserDbHelper();

  @override
  initState() {
    super.initState();
    _checkFlag();
  }

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource(widget.strSound));
  }

  Future<void> _checkFlag() async {
    final int? userId = await SharedPreferencesUsers.getUserId();
    final ModelUser? user = await userDatabaseHelper.getUserById(userId!);
    final List<int>? bookmarkUser = user?.bookmark_number;
    bool alreadyBookmarked = (bookmarkUser ?? []).contains(widget.strNo);
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
                  widget.strTranslate,
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
                  child: TextButton(
                    onPressed: () async {
                      await _playSound();
                    },
                    child: Text(
                      widget.strName,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: widget.strColor,
                      ),
                    ),
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                  ),
                ),
                Center(
                  child: Text(
                    widget.strTranslate,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  widget.strKeterangan,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.strAmalan,
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
            final ModelUser? user =
                await userDatabaseHelper.getUserById(userId!);
            final List<int>? bookmarkUser = user?.bookmark_number;

            if (bookmarkUser == null) {
              print("User has no bookmarks.");
            }

            bool alreadyBookmarked = (bookmarkUser ?? []).contains(widget.strNo);

            setState(() {
              isFlagged = alreadyBookmarked;
            });

            if (!isFlagged) {
              await userDatabaseHelper.updateBookmarkForUser(userId, widget.strNo);
              await bookmarkDatabaseHelper.saveData(
                ModelBookmark(
                  number: widget.strNo,
                  name: widget.strName,
                  transliteration: widget.strTranslate,
                  meaning: widget.strMeaning,
                  keterangan: widget.strKeterangan,
                  amalan: widget.strAmalan,
                  sound: widget.strSound,
                  flag: 'Y',
                ),
              );
            } else {
              await userDatabaseHelper.deleteBookmarkFromUser(userId, widget.strNo);
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
