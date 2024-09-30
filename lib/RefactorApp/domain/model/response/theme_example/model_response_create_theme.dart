// To parse this JSON data, do
//
//     final modelResponseCreateTheme = modelResponseCreateThemeFromJson(jsonString);

import 'dart:convert';

ModelResponseCreateTheme modelResponseCreateThemeFromJson(String str) =>
    ModelResponseCreateTheme.fromJson(json.decode(str));

String modelResponseCreateThemeToJson(ModelResponseCreateTheme data) =>
    json.encode(data.toJson());

class ModelResponseCreateTheme {
  String code;
  String message;
  String messageError;
  ResultModelResponseCreateTheme result;

  ModelResponseCreateTheme({
    required this.code,
    required this.message,
    required this.messageError,
    required this.result,
  });

  ModelResponseCreateTheme copyWith({
    String? code,
    String? message,
    String? messageError,
    ResultModelResponseCreateTheme? result,
  }) =>
      ModelResponseCreateTheme(
        code: code ?? this.code,
        message: message ?? this.message,
        messageError: messageError ?? this.messageError,
        result: result ?? this.result,
      );

  factory ModelResponseCreateTheme.fromJson(Map<String, dynamic> json) =>
      ModelResponseCreateTheme(
        code: json["code"],
        message: json["message"],
        messageError: json["messageError"] ?? "",
        result: ResultModelResponseCreateTheme.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "messageError": messageError,
        "result": result.toJson(),
      };
}

class ResultModelResponseCreateTheme {
  String id;
  String themeName;
  String themeColor;
  String bgImage;
  String fgImage;
  DateTime createdAt;

  ResultModelResponseCreateTheme({
    required this.id,
    required this.themeName,
    required this.themeColor,
    required this.bgImage,
    required this.fgImage,
    required this.createdAt,
  });

  ResultModelResponseCreateTheme copyWith({
    String? id,
    String? themeName,
    String? themeColor,
    String? bgImage,
    String? fgImage,
    DateTime? createdAt,
  }) =>
      ResultModelResponseCreateTheme(
        id: id ?? this.id,
        themeName: themeName ?? this.themeName,
        themeColor: themeColor ?? this.themeColor,
        bgImage: bgImage ?? this.bgImage,
        fgImage: fgImage ?? this.fgImage,
        createdAt: createdAt ?? this.createdAt,
      );

  factory ResultModelResponseCreateTheme.fromJson(Map<String, dynamic> json) =>
      ResultModelResponseCreateTheme(
        id: json["id"],
        themeName: json["themeName"],
        themeColor: json["themeColor"],
        bgImage: json["bgImage"],
        fgImage: json["fgImage"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "themeName": themeName,
        "themeColor": themeColor,
        "bgImage": bgImage,
        "fgImage": fgImage,
        "createdAt": createdAt.toIso8601String(),
      };
}
