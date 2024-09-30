// To parse this JSON data, do
//
//     final modelRequestCreateTheme = modelRequestCreateThemeFromJson(jsonString);

import 'dart:convert';

ModelRequestCreateTheme modelRequestCreateThemeFromJson(String str) =>
    ModelRequestCreateTheme.fromJson(json.decode(str));

String modelRequestCreateThemeToJson(ModelRequestCreateTheme data) =>
    json.encode(data.toJson());

class ModelRequestCreateTheme {
  String themeName;
  String themeColor;
  String fgImage;
  String bgImage;

  ModelRequestCreateTheme({
    required this.themeName,
    required this.themeColor,
    required this.bgImage,
    required this.fgImage,
  });

  ModelRequestCreateTheme copyWith({
    String? themeName,
    String? themeColor,
    String? bgImage,
    String? fgImage,
  }) =>
      ModelRequestCreateTheme(
        themeName: themeName ?? this.themeName,
        themeColor: themeColor ?? this.themeColor,
        bgImage: bgImage ?? this.bgImage,
        fgImage: fgImage ?? this.fgImage,
      );

  factory ModelRequestCreateTheme.fromJson(Map<String, dynamic> json) =>
      ModelRequestCreateTheme(
        themeName: json["themeName"],
        themeColor: json["themeColor"],
        bgImage: json["bgImage"],
        fgImage: json["fgImage"],
      );

  Map<String, dynamic> toJson() => {
        "themeName": themeName,
        "themeColor": themeColor,
        "bgImage": bgImage,
        "fgImage": fgImage,
      };
}
