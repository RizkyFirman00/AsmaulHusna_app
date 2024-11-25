class ModelHijaiyah {
  int? number;
  String? name;
  String? transliteration;
  String? color;
  String? sound;

  ModelHijaiyah(this.number, this.name, this.transliteration, this.color, this.sound);

  ModelHijaiyah.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    transliteration = json['transliteration'];
    color = json['color'];
    sound = json['sound'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'transliteration': transliteration,
      'number': number,
      'color': color,
      'sound': sound,
    };
  }
}
