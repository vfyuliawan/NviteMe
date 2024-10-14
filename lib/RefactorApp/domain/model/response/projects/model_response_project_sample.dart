// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ModelResponseGetProject {
  String code;
  String message;
  dynamic messageError;
  ResultProjectSample result;

  ModelResponseGetProject({
    required this.code,
    required this.message,
    required this.messageError,
    required this.result,
  });

  factory ModelResponseGetProject.fromRawJson(String str) =>
      ModelResponseGetProject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelResponseGetProject.fromJson(Map<String, dynamic> json) =>
      ModelResponseGetProject(
        code: json["code"],
        message: json["message"],
        messageError: json["messageError"],
        result: ResultProjectSample.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "messageError": messageError,
        "result": result.toJson(),
      };
}

class ResultProjectSample {
  List<ListProject> projects;
  Paging paging;

  ResultProjectSample({
    required this.projects,
    required this.paging,
  });

  factory ResultProjectSample.fromRawJson(String str) =>
      ResultProjectSample.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultProjectSample.fromJson(Map<String, dynamic> json) =>
      ResultProjectSample(
        projects: List<ListProject>.from(
            json["projects"].map((x) => ListProject.fromJson(x))),
        paging: Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "projects": List<dynamic>.from(projects.map((x) => x.toJson())),
        "paging": paging.toJson(),
      };

  ResultProjectSample copyWith({
    List<ListProject>? projects,
    Paging? paging,
  }) {
    return ResultProjectSample(
      projects: projects ?? this.projects,
      paging: paging ?? this.paging,
    );
  }
}

class Paging {
  int currentPage;
  int totalPage;
  int size;

  Paging({
    required this.currentPage,
    required this.totalPage,
    required this.size,
  });

  factory Paging.fromRawJson(String str) => Paging.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
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

class ListProject {
  String id;
  String username;
  String title;
  DateTime date;
  Theme theme;
  String heroImage;
  String quotes;

  ListProject({
    required this.id,
    required this.username,
    required this.title,
    required this.date,
    required this.theme,
    required this.heroImage,
    required this.quotes,
  });

  factory ListProject.fromRawJson(String str) =>
      ListProject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListProject.fromJson(Map<String, dynamic> json) => ListProject(
      id: json["id"],
      username: json["username"],
      title: json["title"],
      date: DateTime.parse(json["date"]),
      theme: Theme.fromJson(json["theme"]),
      heroImage: json["heroImage"],
      quotes: json["quotes"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "title": title,
        "date": date.toIso8601String(),
        "theme": theme.toJson(),
        "heroImage": heroImage,
        "quotes": quotes,
      };
}

class Theme {
  String slug;
  String alamat;
  String embeded;
  ThemeUsed theme;
  String music;

  Theme({
    required this.slug,
    required this.alamat,
    required this.embeded,
    required this.theme,
    required this.music,
  });

  factory Theme.fromRawJson(String str) => Theme.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Theme.fromJson(Map<String, dynamic> json) => Theme(
        slug: json["slug"],
        alamat: json["alamat"],
        embeded: json["embeded"],
        theme: ThemeUsed.fromJson(json["theme"]),
        music: json["music"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "alamat": alamat,
        "embeded": embeded,
        "theme": theme,
        "music": music,
      };
}

class ThemeUsed {
  String themeName;
  String primaryColor;
  String secondaryColor;

  ThemeUsed({
    required this.themeName,
    required this.primaryColor,
    required this.secondaryColor,
  });

  ThemeUsed copyWith({
    String? themeName,
    String? primaryColor,
    String? secondaryColor,
  }) =>
      ThemeUsed(
        themeName: themeName ?? this.themeName,
        primaryColor: primaryColor ?? this.primaryColor,
        secondaryColor: secondaryColor ?? this.secondaryColor,
      );

  factory ThemeUsed.fromJson(Map<String, dynamic> json) => ThemeUsed(
        themeName: json["themeName"],
        primaryColor: json["primaryColor"],
        secondaryColor: json["secondaryColor"],
      );

  Map<String, dynamic> toJson() => {
        "themeName": themeName,
        "primaryColor": primaryColor,
        "secondaryColor": secondaryColor,
      };
}
