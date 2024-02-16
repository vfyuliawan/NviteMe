// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:nvite_me/model/UserIdModel.dart';

class AllUserModel {
  List<UserIdModel> userIdModel;
  AllUserModel({
    required this.userIdModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userIdModel': userIdModel.map((x) => x.toJson()).toList(),
    };
  }

  factory AllUserModel.fromMap(Map<String, dynamic> map) {
    return AllUserModel(
      userIdModel: List<UserIdModel>.from(
        (map['userIdModel'] as List<int>).map<UserIdModel>((x) {
          return UserIdModel.fromJson(x as Map<String, dynamic>);
        }),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllUserModel.fromJson(String source) =>
      AllUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
