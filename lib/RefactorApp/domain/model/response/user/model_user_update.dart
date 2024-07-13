import 'dart:convert';

class ModelUserUpdateInterface {
  String name;
  String password;
  String alamat;
  String email;
  String photo;

  ModelUserUpdateInterface({
    required this.name,
    required this.password,
    required this.alamat,
    required this.email,
    required this.photo,
  });

  factory ModelUserUpdateInterface.fromRawJson(String str) =>
      ModelUserUpdateInterface.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelUserUpdateInterface.fromJson(Map<String, dynamic> json) =>
      ModelUserUpdateInterface(
        name: json["name"],
        password: json["password"],
        alamat: json["alamat"],
        email: json["email"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "alamat": alamat,
        "email": email,
        "photo": photo,
      };
}
