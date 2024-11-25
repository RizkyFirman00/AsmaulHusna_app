import 'dart:math';
import 'package:asmaul_husna/database/instances/user_db_helper.dart';
import 'package:asmaul_husna/model/model_bookmark.dart';
import 'package:asmaul_husna/database/instances/bookmark_db_helper.dart';
import 'package:asmaul_husna/tools/shared_preferences_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../model/model_user.dart';
import '../home/detail_home_page.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final BookmarkDbHelper _databaseHelper = BookmarkDbHelper();
  final UserDbHelper _userDbHelper = UserDbHelper();

  List<ModelBookmark> _listBookmarks = [];
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  // Load bookmarks and check if database contains data
  Future<void> _loadBookmarks() async {
    int? userId = await SharedPreferencesUsers.getUserId();
    final ModelUser? modelUser = await _userDbHelper.getUserById(userId!);
    final List<int>? listBookmarksUser = modelUser?.bookmark_number;

    if (listBookmarksUser == null || listBookmarksUser.isEmpty) {
      setState(() {
        _listBookmarks = [];
        _isEmpty = true;
      });
      return;
    }

    final bookmarks = await _databaseHelper.getAllBookmarks();
    final filteredBookmarks = bookmarks.where((bookmark) {
      return listBookmarksUser.contains(bookmark.number);
    }).toList();

    setState(() {
      _listBookmarks = filteredBookmarks;
      _isEmpty = _listBookmarks.isEmpty;
    });
  }

  // Delete a bookmark and update the UI
  Future<void> _deleteBookmark(ModelBookmark bookmark, int index) async {
    await _databaseHelper.deleteBookmarkByNumber(bookmark.number!);
    setState(() {
      _listBookmarks.removeAt(index);
      _isEmpty = _listBookmarks.isEmpty;
    });
  }

  Color _getRandomColor() {
    final random = Random();
    return Color.fromARGB(
        255, random.nextInt(200), random.nextInt(200), random.nextInt(200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isEmpty
          ? Center(
              child: const Text(
                "Ups, belum ada bookmark.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: _listBookmarks.length,
              itemBuilder: (context, index) {
                final bookmark = _listBookmarks[index];
                return GestureDetector(
                  onLongPress: () => _showDeleteDialog(bookmark, index),
                  onTap: () => _navigateToDetail(bookmark),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SvgPicture.asset(
                                  'assets/images/no.svg',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                child: Text(
                                  bookmark.number.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              bookmark.transliteration ?? '',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              bookmark.meaning ?? '',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            bookmark.name ?? '',
                            style: TextStyle(
                                fontSize: 24, color: _getRandomColor()),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  // Show delete confirmation dialog
  void _showDeleteDialog(ModelBookmark bookmark, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Data", style: TextStyle(fontSize: 18)),
        content:
            const Text("Yakin hapus data ini?", style: TextStyle(fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () {
              _deleteBookmark(bookmark, index);
              Navigator.pop(context);
            },
            child: const Text("Hapus", style: TextStyle(fontSize: 14)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  // Navigate to detail page
  void _navigateToDetail(ModelBookmark bookmark) {
    Color randomColor = _getRandomColor();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailHomePage(
          strNo: bookmark.number!,
          strMeaning: bookmark.meaning ?? '',
          strName: bookmark.name ?? '',
          strTranslate: bookmark.transliteration ?? '',
          strKeterangan: bookmark.keterangan ?? '',
          strAmalan: bookmark.amalan ?? '',
          strSound: bookmark.sound ?? '',
          strColor: randomColor,
        ),
      ),
    ).then((_) {
      _loadBookmarks();
    });
  }
}
