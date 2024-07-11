import 'package:meta/meta.dart';
import 'dart:convert';

class ModelUserUpdateInterface {
  String name;
  String password;
  String alamat;
  String email;

  ModelUserUpdateInterface({
    required this.name,
    required this.password,
    required this.alamat,
    required this.email,
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
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "alamat": alamat,
        "email": email,
      };
}
