// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

HeroModel HeroModelFromJson(String str) => HeroModel.fromJson(json.decode(str));

String HeroModelToJson(HeroModel data) => json.encode(data.toJson());

class HeroModel {
  bool? isOpen;
  String? tittle;
  String? icon;
  Timestamp? heroDate;
  File? heroImgFile;
  String? heroImg;
  String? heroTittle;
  bool? visible;

  HeroModel({
    this.isOpen = false,
    this.tittle = "Hero",
    this.icon = "assets/icons/painting.png",
    this.heroDate,
    this.heroImgFile,
    this.heroImg,
    this.heroTittle,
    this.visible = true,
  });

  factory HeroModel.fromJson(Map<String, dynamic> json) => HeroModel(
        isOpen: json['isOpen'] ?? false,
        tittle: json['title'] ?? "Hero",
        icon: json['icon'] ?? "assets/icons/painting.png",
        heroDate: json["HeroDate"],
        heroImg: json["HeroImg"],
        heroTittle: json["HeroTittle"],
        visible: json["Visible"],
        heroImgFile: null,
      );

  Map<String, dynamic> toJson() => {
        "HeroDate": heroDate,
        "HeroImg": heroImg,
        "HeroTittle": heroTittle,
        "Visible": visible,
      };
}
