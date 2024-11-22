import 'dart:math';

import 'package:asmaul_husna/model/model_bookmark.dart';
import 'package:asmaul_husna/database/bookmarkDb_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../home/detail_home_page.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<ModelBookmark> listBookmark = [];
  BookmarkDbHelper databaseHelper = BookmarkDbHelper();
  int strCheckDatabase = 0;

  @override
  void initState() {
    super.initState();
    getDatabase();
    getAllData();
  }

  //cek database ada data atau tidak
  Future<void> getDatabase() async {
    var checkDB = await databaseHelper.cekDataBookmark();
    setState(() {
      if (checkDB == 0) {
        strCheckDatabase = 0;
      } else {
        strCheckDatabase = checkDB!;
      }
    });
  }

  //get data untuk menampilkan ke listview
  Future<void> getAllData() async {
    var listData = await databaseHelper.getDataBookmark();
    setState(() {
      listBookmark.clear();
      listData!.forEach((data) {
        listBookmark.add(ModelBookmark.fromMap(data));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color getRandomColor() {
      Random random = Random();
      return Color.fromARGB(255, random.nextInt(200), random.nextInt(200), random.nextInt(200));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            strCheckDatabase == 0
                ? Container(
                padding: const EdgeInsets.only(top: 250),
                child: const Center(
                  child: Text("Ups, belum ada bookmark.",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ))
                : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listBookmark.length,
                itemBuilder: (context, index) {
                  ModelBookmark modelbookmark = listBookmark[index];
                  return GestureDetector(
                    onLongPress: () {
                      AlertDialog alertDialog = AlertDialog(
                        title: const Text("Hapus Data",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        content: const SizedBox(
                          height: 20,
                          child: Column(
                            children: [
                              Text("Yakin hapus data ini?",
                                style: TextStyle(fontSize: 14, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              deleteData(modelbookmark, index);
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: const Text("Hapus",
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: const Text("Batal",
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                        ],
                      );
                      showDialog(
                          context: context,
                          builder: (context) => alertDialog);
                    },
                    onTap: () {
                      String strNo = listBookmark[index].number.toString();
                      String strMeaning = listBookmark[index].meaning.toString();
                      String strName = listBookmark[index].name.toString();
                      String strTranslate = listBookmark[index].transliteration.toString();
                      String strKeterangan = listBookmark[index].keterangan.toString();
                      String strAmalan = listBookmark[index].amalan.toString();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailHomePage(
                              strNo: strNo,
                              strMeaning: strMeaning,
                              strName: strName,
                              strTranslate: strTranslate,
                              strKeterangan: strKeterangan,
                              strAmalan: strAmalan),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                                    modelbookmark.number.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    modelbookmark.transliteration.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    modelbookmark.meaning.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              modelbookmark.name.toString(),
                              style: TextStyle(fontSize: 24, color: getRandomColor()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  //untuk hapus data berdasarkan Id
  Future<void> deleteData(ModelBookmark modelBookmark, int position) async {
    await databaseHelper.deleteBookmark(modelBookmark.id!);
    setState(() {
      getDatabase();
      listBookmark.removeAt(position);
    });
  }
}