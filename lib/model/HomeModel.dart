// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  bool? isOpen;
  String? tittle;
  String? icon;
  String? homeImg;
  File? homeImgFile;
  String? homeQuotes;
  String? homeTittle;
  bool? visible;

  HomeModel({
    this.isOpen = false,
    this.tittle = "Home",
    this.icon = "assets/icons/homework.png",
    this.homeImg,
    this.homeImgFile,
    this.homeQuotes,
    this.homeTittle,
    this.visible = true,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        isOpen: json['isOpen'] ?? false,
        tittle: json['title'] ?? "Home",
        icon: json['icon'] ?? "assets/icons/homework.png",
        homeImg: json["HomeImg"],
        homeQuotes: json["HomeQuotes"],
        homeTittle: json["HomeTittle"],
        visible: json["Visible"] ?? false,
        homeImgFile: null,
      );

  Map<String, dynamic> toJson() => {
        "HomeImg": homeImg,
        "HomeQuotes": homeQuotes,
        "HomeTittle": homeTittle,
        "Visible": visible,
      };
}
