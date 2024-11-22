class ModelUser {
  int? id;
  String? email;
  String? phoneNumber;
  String? username;
  String? password;

  ModelUser(
      {this.id, this.email, this.phoneNumber, this.username, this.password});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['username'] = username;
    map['password'] = password;

    return map;
  }

  ModelUser.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    email = map['email'];
    phoneNumber = map['phoneNumber'];
    username = map['username'];
    password = map['password'];
  }
}
