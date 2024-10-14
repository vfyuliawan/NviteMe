// To parse this JSON data, do
//
//     final modelResponseCekSlug = modelResponseCekSlugFromJson(jsonString);

import 'dart:convert';

ModelResponseCekSlug modelResponseCekSlugFromJson(String str) =>
    ModelResponseCekSlug.fromJson(json.decode(str));

String modelResponseCekSlugToJson(ModelResponseCekSlug data) =>
    json.encode(data.toJson());

class ModelResponseCekSlug {
  String code;
  String message;
  dynamic messageError;
  bool result;

  ModelResponseCekSlug({
    required this.code,
    required this.message,
    required this.messageError,
    required this.result,
  });

  factory ModelResponseCekSlug.fromJson(Map<String, dynamic> json) =>
      ModelResponseCekSlug(
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
