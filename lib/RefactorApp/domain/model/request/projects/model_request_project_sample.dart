import 'dart:convert';

class ModelRequestProjectSample {
  String title;
  int currentPage;
  int size;

  ModelRequestProjectSample({
    required this.title,
    required this.currentPage,
    required this.size,
  });

  factory ModelRequestProjectSample.fromRawJson(String str) =>
      ModelRequestProjectSample.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelRequestProjectSample.fromJson(Map<String, dynamic> json) =>
      ModelRequestProjectSample(
        title: json["title"],
        currentPage: json["currentPage"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "currentPage": currentPage,
        "size": size,
      };
}
