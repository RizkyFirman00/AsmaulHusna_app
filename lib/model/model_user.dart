import 'package:hive/hive.dart';

part 'model_user.g.dart';

@HiveType(typeId: 0)
class ModelUser extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? email;

  @HiveField(2)
  String? phoneNumber;

  @HiveField(3)
  String? username;

  @HiveField(4)
  String? password;

  @HiveField(5)
  List<int>? bookmark_number;

  ModelUser({this.id, this.email, this.phoneNumber, this.username, this.password, this.bookmark_number});
}
