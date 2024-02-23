// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final maleFemaleModel = maleFemaleModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

MaleFemaleModel maleFemaleModelFromJson(String str) =>
    MaleFemaleModel.fromJson(json.decode(str));

String maleFemaleModelToJson(MaleFemaleModel data) =>
    json.encode(data.toJson());

class MaleFemaleModel {
  Male? female;
  bool? visible;
  Male? male;
  bool? isOpen;
  String? tittle;
  String? icon;

  MaleFemaleModel({
    this.isOpen = true,
    this.tittle = "Braid Information",
    this.icon = "assets/icons/male-femla.png",
    this.female,
    this.visible = true,
    this.male,
  });

  factory MaleFemaleModel.fromJson(Map<String, dynamic> json) =>
      MaleFemaleModel(
        female: Male.fromJson(json["Female"]),
        visible: json["Visible"],
        male: Male.fromJson(json["Male"]),
        isOpen: json['isOpen'] ?? false,
        tittle: json['title'] ?? "Male-Female",
        icon: json['icon'] ?? "assets/icons/male-femla.png",
      );

  Map<String, dynamic> toJson() => {
        "Female": female!.toJson(),
        "Visible": visible,
        "Male": male!.toJson(),
      };

  MaleFemaleModel copyWith({
    Male? female,
    bool? visible,
    Male? male,
    bool? isOpen,
    String? tittle,
    String? icon,
  }) {
    return MaleFemaleModel(
      female: female ?? this.female,
      visible: visible ?? this.visible,
      male: male ?? this.male,
      isOpen: isOpen ?? this.isOpen,
      tittle: tittle ?? this.tittle,
      icon: icon ?? this.icon,
    );
  }
}

class Male {
  String? ibu;
  String? photo;
  String? oldPhoto;
  File? photoFile;
  String? name;
  String? ayah;
  bool? isOpen;

  Male({
    this.ibu,
    this.photo,
    this.oldPhoto,
    this.photoFile,
    this.name,
    this.ayah,
    this.isOpen = true,
  });

  factory Male.fromJson(Map<String, dynamic> json) => Male(
        ibu: json["Ibu"],
        photo: json["Photo"],
        oldPhoto: json["Photo"],
        name: json["Name"],
        ayah: json["Ayah"],
        isOpen: false,
      );

  Map<String, dynamic> toJson() => {
        "Ibu": ibu,
        "Photo": photo,
        "Name": name,
        "Ayah": ayah,
      };
}
