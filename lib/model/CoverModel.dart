// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final coverModel = coverModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

CoverModel coverModelFromJson(String str) =>
    CoverModel.fromJson(json.decode(str));

String coverModelToJson(CoverModel data) => json.encode(data.toJson());

class CoverModel {
  bool? isOpen;
  String? tittle;
  String? icon;
  String? imgCover;
  File? imgFileCover;
  bool? visible;
  String? titleCover;
  Timestamp? date;

  CoverModel({
    this.isOpen = false,
    this.tittle = "Cover Depan",
    this.icon = "assets/icons/cover-letter.png",
    this.imgCover,
    this.imgFileCover,
    this.visible = true,
    this.titleCover,
    this.date,
  });

  factory CoverModel.fromJson(Map<String, dynamic> json) => CoverModel(
        isOpen: json['isOpen'] ?? false,
        tittle: json['title'] ?? "Cover Depan",
        icon: json['icon'] ?? "assets/icons/cover-letter.png",
        imgCover: json["ImgCover"],
        visible: json["Visible"] ?? false,
        titleCover: json["TitleCover"],
        date: json["Date"],
      );

  Map<String, dynamic> toJson() => {
        "ImgCover": imgCover,
        "Visible": visible,
        "TitleCover": titleCover,
        "Date": date,
      };
}
