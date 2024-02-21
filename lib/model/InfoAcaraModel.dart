// To parse this JSON data, do
//
//     final infoAcara = infoAcaraFromJson(jsonString);

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class InfoAcaraModel {
  List<InfoAcaraElement>? infoAcara;
  bool? isOpen;
  String? tittle;
  String? icon;

  InfoAcaraModel({
    this.isOpen = false,
    this.tittle = "Info Acara",
    this.icon = "assets/icons/homework.png",
    List<InfoAcaraElement>? infoAcara,
  }) : infoAcara = infoAcara ?? [InfoAcaraElement(), InfoAcaraElement()];

  factory InfoAcaraModel.fromJson(Map<String, dynamic> json) => InfoAcaraModel(
      infoAcara: json['InfoAcara'] != null
          ? (json['InfoAcara'] as List<dynamic>)
              .map((x) => InfoAcaraElement.fromJson(x as Map<String, dynamic>))
              .toList()
          : null,
      isOpen: false,
      icon: "assets/icons/info.png",
      tittle: "Info Acara");

  Map<String, dynamic> toJson() => {
        "InfoAcara": List<dynamic>.from(infoAcara!.map((x) => x.toJson())),
      };
}

class InfoAcaraElement {
  bool? isOpen;
  Timestamp? date;
  String? judul;
  String? map;
  String? oldPhoto;
  String? photo;
  File? photoFile;
  String? place;

  InfoAcaraElement({
    this.isOpen = true,
    Timestamp? date,
    this.oldPhoto,
    this.photoFile,
    this.judul,
    this.map,
    this.photo,
    this.place,
  }) : date = date ?? Timestamp.now();

  factory InfoAcaraElement.fromJson(Map<String, dynamic> json) =>
      InfoAcaraElement(
        isOpen: false,
        date: json["Date"],
        judul: json["Judul"],
        map: json["Map"],
        photo: json["Photo"],
        oldPhoto: json["Photo"],
        place: json["Place"],
      );

  Map<String, dynamic> toJson() => {
        "Date": date,
        "Judul": judul,
        "Map": map,
        "Photo": photo,
        "Place": place,
      };
}
