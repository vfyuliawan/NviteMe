// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:nvite_me/model/CountDownModel.dart';
import 'package:nvite_me/model/CoverModel.dart';
import 'package:nvite_me/model/FooterModel.dart';
import 'package:nvite_me/model/GaleryModel.dart';
import 'package:nvite_me/model/GiftsModel.dart';
import 'package:nvite_me/model/HeroModel.dart';
import 'package:nvite_me/model/HomeModel.dart';
import 'package:nvite_me/model/InfoAcaraModel.dart';
import 'package:nvite_me/model/MaleFemaleModel.dart';
import 'package:nvite_me/model/MessageModel.dart';
import 'package:nvite_me/model/OurStoryModel.dart';

UserIdModel userIdFromJson(String str) =>
    UserIdModel.fromJson(json.decode(str));

String userIdToJson(UserIdModel data) => json.encode(data.toJson());

class UserIdModel {
  HomeModel? home;
  CoverModel? cover;
  HeroModel? hero;
  InfoAcaraModel? infoAcara;
  MaleFemaleModel? maleFemale;
  OurStoryModel? ourStory;
  GaleryModel? galery;
  GiftstModel? gifts;
  CountDownModel? countDown;
  MessageModel? message;
  FooterModel? footer;
  String? slug;
  String? themeName;
  String? themeSong;
  bool? guestBarcode;

  UserIdModel({
    MessageModel? message,
    this.home,
    this.cover,
    this.hero,
    this.infoAcara,
    this.maleFemale,
    this.ourStory,
    this.galery,
    this.gifts,
    this.countDown,
    FooterModel? footer,
    this.slug,
    this.themeName,
    this.themeSong,
    this.guestBarcode,
  })  : message = message ?? MessageModel(),
        footer = footer ?? FooterModel();

  factory UserIdModel.fromJson(Map<String, dynamic> json) {
    return UserIdModel(
      cover: json["Cover"] != null ? CoverModel.fromJson(json["Cover"]) : null,
      home: json["Home"] != null ? HomeModel.fromJson(json["Home"]) : null,
      hero: json["Hero"] != null ? HeroModel.fromJson(json["Hero"]) : null,
      infoAcara:
          json["InfoAcara"] != null ? InfoAcaraModel.fromJson(json) : null,
      maleFemale: json['MaleFemale'] != null
          ? MaleFemaleModel.fromJson(json["MaleFemale"])
          : null,
      ourStory: json["OurStory"] != null
          ? OurStoryModel.fromJson(json["OurStory"])
          : null,
      galery:
          json["Galery"] != null ? GaleryModel.fromJson(json["Galery"]) : null,
      gifts: json["Gifts"] != null ? GiftstModel.fromJson(json["Gifts"]) : null,
      countDown: json["CountDown"] != null
          ? CountDownModel.fromJson(json["CountDown"])
          : CountDownModel(),
      slug: json["Slug"],
      themeName: json["ThemeName"] ?? "RedEssence",
      themeSong: json["ThemeSong"],
      guestBarcode: json["GuestBarcode"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "Cover": cover?.toJson(),
        "Home": home?.toJson(),
        "Hero": hero?.toJson(),
        "InfoAcara":
            List<dynamic>.from(infoAcara!.infoAcara!.map((x) => x.toJson())),
        "MaleFemale": maleFemale?.toJson(),
        "OurStory": ourStory?.toJson(),
        "Galery": galery?.toJson(),
        "Gifts": gifts?.toJson(),
        "CountDown": countDown?.toJson(),
        "Message": List<dynamic>.from(message!.message!.map((x) => x.toJson())),
        "Footer": footer?.toJson(),
        "Slug": slug,
        "ThemeName": themeName,
        "ThemeSong": themeSong,
        "GuestBarcode": guestBarcode
      };
}
