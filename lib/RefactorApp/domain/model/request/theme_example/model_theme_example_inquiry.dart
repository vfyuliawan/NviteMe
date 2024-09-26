import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ModelThemeExampleInquiry {
  String themeName;
  int currentPage;
  int pageSize;
  ModelThemeExampleInquiry({
    required this.themeName,
    required this.currentPage,
    required this.pageSize,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'themeName': themeName,
      'currentPage': currentPage,
      'pageSize': pageSize,
    };
  }

  factory ModelThemeExampleInquiry.fromMap(Map<String, dynamic> map) {
    return ModelThemeExampleInquiry(
      themeName: map['themeName'] as String,
      currentPage: map['currentPage'] as int,
      pageSize: map['pageSize'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelThemeExampleInquiry.fromJson(String source) =>
      ModelThemeExampleInquiry.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
