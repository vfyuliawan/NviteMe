import 'dart:convert';

class ModelResponseLoginInterface {
  String code;
  String message;
  dynamic messageError;
  Result result;

  ModelResponseLoginInterface({
    required this.code,
    required this.message,
    required this.messageError,
    required this.result,
  });

  factory ModelResponseLoginInterface.fromRawJson(String str) =>
      ModelResponseLoginInterface.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelResponseLoginInterface.fromJson(Map<String, dynamic> json) =>
      ModelResponseLoginInterface(
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
  String token;
  int tokenExpiredAt;

  Result({
    required this.username,
    required this.token,
    required this.tokenExpiredAt,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        username: json["username"],
        token: json["token"],
        tokenExpiredAt: json["tokenExpiredAt"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "token": token,
        "tokenExpiredAt": tokenExpiredAt,
      };
}
