import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class DetailHijaiyahPage extends StatefulWidget {
  final String name;
  final String transliteration;
  final String number;
  final String color;
  final String sound;

  const DetailHijaiyahPage({
    super.key,
    required this.name,
    required this.transliteration,
    required this.number,
    required this.color,
    required this.sound,
  });

  @override
  State<DetailHijaiyahPage> createState() => _DetailHijaiyahPageState();
}

class _DetailHijaiyahPageState extends State<DetailHijaiyahPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource(widget.sound));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Color(0xff4caf50),
              expandedHeight: 250,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.transliteration,
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
              TextButton(
                onPressed: () async {_playSound();},
                child: Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Color(
                      int.parse(
                        widget.color.replaceAll("#", "0xFF"),
                      ),
                    ),
                  ),
                ),
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
              ),
              const SizedBox(height: 10),
              Text(
                widget.transliteration,
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
                'Huruf ${widget.transliteration} adalah huruf ke-${widget.number} dalam urutan alfabet Hijaiyah. Simbol huruf ini adalah "${widget.name}", dan sering digunakan dalam bacaan bahasa Arab, termasuk dalam Al-Qur\'an. Mengenal huruf ini penting untuk membaca dan memahami teks Arab dengan baik.',
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
