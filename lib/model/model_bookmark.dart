import 'package:hive/hive.dart';

part 'model_bookmark.g.dart';

@HiveType(typeId: 1)
class ModelBookmark extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? number;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? transliteration;

  @HiveField(4)
  String? meaning;

  @HiveField(5)
  String? flag;

  @HiveField(6)
  String? keterangan;

  @HiveField(7)
  String? amalan;

  ModelBookmark({
    this.id,
    this.number,
    this.name,
    this.transliteration,
    this.meaning,
    this.flag,
    this.keterangan,
    this.amalan,
  });
}