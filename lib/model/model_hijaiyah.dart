class ModelHijaiyah {
  int? number;
  String? name;
  String? transliteration;
  String? color;

  ModelHijaiyah(this.number, this.name, this.transliteration, this.color);

  ModelHijaiyah.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    transliteration = json['transliteration'];
    color = json['color'];
  }
}
