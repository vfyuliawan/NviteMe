import 'dart:convert';
import 'dart:io';

// ignore_for_file: public_member_api_docs, sort_constructors_first

GaleryModel infoAcaraFromJson(String str) =>
    GaleryModel.fromJson(json.decode(str));

String infoAcaraToJson(GaleryModel data) => json.encode(data.toJson());

class GaleryModel {
  bool? isOpen;
  String? tittle;
  String? icon;
  bool? visible;
  List<String>? image;
  List<File>? imageFile;
  List<String>? oldImage;

  GaleryModel({
    this.isOpen = true,
    this.tittle = "Galery",
    this.icon = "assets/icons/image-files.png",
    this.visible = true,
    this.image,
    this.imageFile,
    this.oldImage,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Visible': visible,
      'image': image,
    };
  }

  factory GaleryModel.fromJson(Map<String, dynamic> json) {
    return GaleryModel(
      isOpen: false,
      icon: "assets/icons/image-files.png",
      tittle: "Our Galery",
      visible: json['Visible'] != null ? json['Visible'] as bool : null,
      image: json["image"] != null ? List<String>.from(json['image']) : null,
      oldImage: json["image"] != null ? List<String>.from(json['image']) : null,
    );
  }
}
