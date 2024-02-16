import 'package:flutter/material.dart';
import 'package:nvite_me/model/CoverModel.dart';
import 'package:nvite_me/model/HomeModel.dart';

class UserIdModelTest {
  HomeModel? home;
  CoverModel? cover;

  UserIdModelTest({this.home, this.cover});

  factory UserIdModelTest.fromJson(Map<String, dynamic> json) {
    return UserIdModelTest(
      cover: json["Cover"] != null ? CoverModel.fromJson(json["Cover"]) : null,
      home: json["Home"] != null ? HomeModel.fromJson(json["Home"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "Cover": cover?.toJson(),
        "Home": home?.toJson(),
      };

  List<Map<String, dynamic>> toList() {
    List<Map<String, dynamic>> result = [];

    if (cover != null) {
      result.add({
        "name": "Cover Depan",
        "icon": Image.asset("assets/icons/cover-letter.png", fit: BoxFit.cover),
        "isOpen": true,
        "form": cover!.toJson(),
      });
    }

    if (home != null) {
      result.add({
        "name": "Home",
        "icon": Image.asset("assets/icons/homework.png"),
        "isOpen": true,
        "form": home!.toJson(),
      });
    }

    return result;
  }
}
