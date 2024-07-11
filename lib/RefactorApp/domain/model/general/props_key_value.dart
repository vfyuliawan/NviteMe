// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PropsKeyValue {
  final String key;
  final String value;

  PropsKeyValue({
    required this.key,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'value': value,
    };
  }

  factory PropsKeyValue.fromMap(Map<String, dynamic> map) {
    return PropsKeyValue(
      key: map['key'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PropsKeyValue.fromJson(String source) =>
      PropsKeyValue.fromMap(json.decode(source) as Map<String, dynamic>);
}
