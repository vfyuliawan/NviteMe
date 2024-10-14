// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ModelRequesCekSlug {
  final String slug;

  ModelRequesCekSlug({required this.slug});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slug': slug,
    };
  }

  factory ModelRequesCekSlug.fromMap(Map<String, dynamic> map) {
    return ModelRequesCekSlug(
      slug: map['slug'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequesCekSlug.fromJson(String source) =>
      ModelRequesCekSlug.fromMap(json.decode(source) as Map<String, dynamic>);
}
