import 'package:flutter/material.dart';

class DetailHijaiyahPage extends StatelessWidget {
  final String name;
  final String transliteration;
  final String number;
  final String color;

  const DetailHijaiyahPage({
    super.key,
    required this.name,
    required this.transliteration,
    required this.number,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    Color parsedColor;
    try {
      parsedColor = Color(int.parse(color.replaceAll('0xff', '0x'), radix: 16));
    } catch (e) {
      parsedColor = const Color(0xff4caf50);
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: parsedColor,
              expandedHeight: 250,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  transliteration,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                titlePadding: const EdgeInsets.only(left: 52.0, bottom: 16.0),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/banner.jpg',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                name,
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color:
                      parsedColor, // Displaying name with its respective color
                ),
              ),
              const SizedBox(height: 10),
              Text(
                transliteration,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              const Text(
                'Deskripsi:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Huruf $transliteration adalah huruf ke-$number dalam urutan alfabet Hijaiyah. Simbol huruf ini adalah "$name", dan sering digunakan dalam bacaan bahasa Arab, termasuk dalam Al-Qur\'an. Mengenal huruf ini penting untuk membaca dan memahami teks Arab dengan baik.',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
