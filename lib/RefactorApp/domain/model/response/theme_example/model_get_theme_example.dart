// To parse this JSON data, do
//
//     final modelGetThemeExample = modelGetThemeExampleFromJson(jsonString);

import 'dart:convert';

ModelGetThemeExample modelGetThemeExampleFromJson(String str) =>
    ModelGetThemeExample.fromJson(json.decode(str));

String modelGetThemeExampleToJson(ModelGetThemeExample data) =>
    json.encode(data.toJson());

class ModelGetThemeExample {
  String code;
  String message;
  dynamic messageError;
  ResultThemeExample result;

  ModelGetThemeExample({
    required this.code,
    required this.message,
    required this.messageError,
    required this.result,
  });

  ModelGetThemeExample copyWith({
    String? code,
    String? message,
    dynamic messageError,
    ResultThemeExample? result,
  }) =>
      ModelGetThemeExample(
        code: code ?? this.code,
        message: message ?? this.message,
        messageError: messageError ?? this.messageError,
        result: result ?? this.result,
      );

  factory ModelGetThemeExample.fromJson(Map<String, dynamic> json) =>
      ModelGetThemeExample(
        code: json["code"],
        message: json["message"],
        messageError: json["messageError"],
        result: ResultThemeExample.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "messageError": messageError,
        "result": result.toJson(),
      };
}

class ResultThemeExample {
  List<ListTheme> listTheme;
  Pageable pageable;

  ResultThemeExample({
    required this.listTheme,
    required this.pageable,
  });

  ResultThemeExample copyWith({
    List<ListTheme>? listTheme,
    Pageable? pageable,
  }) =>
      ResultThemeExample(
        listTheme: listTheme ?? this.listTheme,
        pageable: pageable ?? this.pageable,
      );

  factory ResultThemeExample.fromJson(Map<String, dynamic> json) =>
      ResultThemeExample(
        listTheme: List<ListTheme>.from(
            json["listTheme"].map((x) => ListTheme.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
      );

  Map<String, dynamic> toJson() => {
        "listTheme": List<dynamic>.from(listTheme.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
      };
}

class ListTheme {
  String id;
  String themeName;
  String themeColor;
  String bgImage;
  String fgImage;
  DateTime createdAt;

  ListTheme({
    required this.id,
    required this.themeName,
    required this.themeColor,
    required this.bgImage,
    required this.fgImage,
    required this.createdAt,
  });

  ListTheme copyWith({
    String? id,
    String? themeName,
    String? themeColor,
    String? bgImage,
    String? fgImage,
    DateTime? createdAt,
  }) =>
      ListTheme(
        id: id ?? this.id,
        themeName: themeName ?? this.themeName,
        themeColor: themeColor ?? this.themeColor,
        bgImage: bgImage ?? this.bgImage,
        fgImage: fgImage ?? this.fgImage,
        createdAt: createdAt ?? this.createdAt,
      );

  factory ListTheme.fromJson(Map<String, dynamic> json) => ListTheme(
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

class Pageable {
  int currentPage;
  int totalPage;
  int size;

  Pageable({
    required this.currentPage,
    required this.totalPage,
    required this.size,
  });

  Pageable copyWith({
    int? currentPage,
    int? totalPage,
    int? size,
  }) =>
      Pageable(
        currentPage: currentPage ?? this.currentPage,
        totalPage: totalPage ?? this.totalPage,
        size: size ?? this.size,
      );

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        currentPage: json["currentPage"],
        totalPage: json["totalPage"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "totalPage": totalPage,
        "size": size,
      };
}
