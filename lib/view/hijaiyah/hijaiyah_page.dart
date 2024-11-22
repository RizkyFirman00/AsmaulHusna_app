import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import '../../model/model_hijaiyah.dart';
import 'detail_hijaiyah_page.dart';

class HijaiyahPage extends StatefulWidget {
  const HijaiyahPage({super.key});

  @override
  State<HijaiyahPage> createState() => _HijaiyahPageState();
}

class _HijaiyahPageState extends State<HijaiyahPage> {
  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
        255, random.nextInt(200), random.nextInt(200), random.nextInt(200));
  }

  // Method to get data from assets
  Future<List<ModelHijaiyah>> readJsonData() async {
    final jsonData =
        await rootBundle.rootBundle.loadString('assets/data/hijaiyah.json');
    final listJson = json.decode(jsonData) as List<dynamic>;
    return listJson.map((e) => ModelHijaiyah.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: readJsonData(),
              builder: (context, data) {
                if (data.hasError) {
                  return Center(child: Text('${data.error}'));
                } else if (data.hasData) {
                  var items = data.data as List<ModelHijaiyah>;
                  return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        // Parse the color
                        Color parsedColor;
                        try {
                          parsedColor = Color(int.parse(
                              items[index].color!.replaceAll('0xff', '0x'),
                              radix: 16));
                        } catch (e) {
                          parsedColor =
                              const Color(0xff4caf50); // Fallback color
                        }

                        return GestureDetector(
                          onTap: () {
                            String strName = items[index].name.toString();
                            String strTransliteration =
                                items[index].transliteration.toString();
                            String strNumber = items[index].number.toString();
                            String strColor = items[index].color.toString();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailHijaiyahPage(
                                    name: strName,
                                    transliteration: strTransliteration,
                                    number: strNumber,
                                    color: strColor),
                              ),
                            );
                          },
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: SvgPicture.asset(
                                          'assets/images/no.svg',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        child: Text(
                                          items[index].number.toString(),
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
                                          items[index]
                                              .transliteration
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    items[index].name.toString(),
                                    style: TextStyle(
                                        fontSize: 24,
                                        color:
                                            getRandomColor() // Displaying name with its respective color
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xff4caf50)),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
