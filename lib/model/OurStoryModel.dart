// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

OurStoryModel ourStoryModalFromJson(String str) =>
    OurStoryModel.fromJson(json.decode(str));

String ourStoryModalToJson(OurStoryModel data) => json.encode(data.toJson());

class OurStoryModel {
  KeyValueOuStory? first;
  KeyValueOuStory? second;
  KeyValueOuStory? third;
  bool? visible;
  bool? isOpen;
  String? tittle;
  String? icon;
  OurStoryModel({
    this.first,
    this.second,
    this.third,
    this.visible = true,
    this.isOpen = true,
    this.tittle = "Our Story",
    this.icon = "assets/icons/love.png",
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'First': first!.toJson(),
      'Second': second!.toJson(),
      'Third': third!.toJson(),
      'Visible': visible,
    };
  }

  factory OurStoryModel.fromJson(Map<String, dynamic> map) {
    return OurStoryModel(
      first:
          map["First"] != null ? KeyValueOuStory.fromJson(map["First"]) : null,
      second: map["Second"] != null
          ? KeyValueOuStory.fromJson(map["Second"])
          : null,
      third:
          map["Third"] != null ? KeyValueOuStory.fromJson(map["Third"]) : null,
      visible: map['Visible'] ?? false,
      isOpen: map['isOpen'] ?? false,
      tittle: map['tittle'] ?? "Our Story",
      icon: map['icon'] ?? "assets/icons/love.png",
    );
  }
}

class KeyValueOuStory {
  Timestamp? date;
  String? photo;
  String? photoOld;
  File? photoFile;
  String? story;
  String? tittle;
  bool? isOpen;

  KeyValueOuStory({
    Timestamp? date,
    this.photo,
    this.photoOld,
    this.photoFile,
    this.story,
    this.tittle,
    this.isOpen = true,
  }) : date = date ?? Timestamp.now();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Date': date,
      'Photo': photo,
      'Story': story,
      'Tittle': tittle,
    };
  }

  factory KeyValueOuStory.fromJson(Map<String, dynamic> json) {
    return KeyValueOuStory(
      date: json['Date'] as Timestamp,
      photo: json['Photo'] as String,
      photoOld: json["Photo"] as String,
      story: json['Story'] as String,
      tittle: json['Tittle'] as String,
      isOpen: json['isOpen'] ?? false,
    );
  }
}
