import 'dart:convert';

class ModelUserResponseInterface {
  String code;
  String message;
  dynamic messageError;
  Result result;

  ModelUserResponseInterface({
    required this.code,
    required this.message,
    required this.messageError,
    required this.result,
  });

  factory ModelUserResponseInterface.fromRawJson(String str) =>
      ModelUserResponseInterface.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelUserResponseInterface.fromJson(Map<String, dynamic> json) =>
      ModelUserResponseInterface(
        code: json["code"],
        message: json["message"],
        messageError: json["messageError"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "messageError": messageError,
        "result": result.toJson(),
      };
}

class Result {
  String username;
  String name;
  String alamat;
  String email;
  String photo;
  String role;

  Result(
      {required this.username,
      required this.name,
      required this.alamat,
      required this.email,
      required this.photo,
      required this.role});

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      username: json["username"] ?? "",
      name: json["name"] ?? "",
      alamat: json["alamat"] ?? "",
      email: json["email"] ?? "",
      photo: json["photo"] ?? "",
      role: json["role"] ?? "");

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "alamat": alamat,
        "email": email,
        "photo": photo,
        "role": role,
      };
}
