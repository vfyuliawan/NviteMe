import 'dart:convert';

class ModelResponseCekLoginInterface {
  String code;
  String message;
  String messageError;
  bool result;

  ModelResponseCekLoginInterface({
    required this.code,
    required this.message,
    required this.messageError,
    required this.result,
  });

  factory ModelResponseCekLoginInterface.fromRawJson(String str) =>
      ModelResponseCekLoginInterface.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelResponseCekLoginInterface.fromJson(Map<String, dynamic> json) =>
      ModelResponseCekLoginInterface(
        code: json["code"],
        message: json["message"],
        messageError: json["messageError"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "messageError": messageError,
        "result": result,
      };
}
