// To parse this JSON data, do
//
//     final modelResponseDeleteTheme = modelResponseDeleteThemeFromJson(jsonString);

import 'dart:convert';

ModelResponseDeleteTheme modelResponseDeleteThemeFromJson(String str) =>
    ModelResponseDeleteTheme.fromJson(json.decode(str));

String modelResponseDeleteThemeToJson(ModelResponseDeleteTheme data) =>
    json.encode(data.toJson());

class ModelResponseDeleteTheme {
  String code;
  String message;
  dynamic messageError;
  bool result;

  ModelResponseDeleteTheme({
    required this.code,
    required this.message,
    required this.messageError,
    required this.result,
  });

  ModelResponseDeleteTheme copyWith({
    String? code,
    String? message,
    dynamic messageError,
    bool? result,
  }) =>
      ModelResponseDeleteTheme(
        code: code ?? this.code,
        message: message ?? this.message,
        messageError: messageError ?? this.messageError,
        result: result ?? this.result,
      );

  factory ModelResponseDeleteTheme.fromJson(Map<String, dynamic> json) =>
      ModelResponseDeleteTheme(
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
