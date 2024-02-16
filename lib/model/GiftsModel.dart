// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'dart:convert';

GiftstModel giftstModelFromJson(String str) =>
    GiftstModel.fromJson(json.decode(str));

String giftstModelToJson(GiftstModel data) => json.encode(data.toJson());

class GiftstModel {
  bool isOpen;
  String tittle;
  String icon;
  GiftsKeyValue? first;
  GiftsKeyValue? second;
  GiftsKeyValue? third;
  bool? visible;
  GiftstModel({
    this.isOpen = true,
    this.tittle = "Gifts",
    this.icon = "assets/icons/gift.png",
    this.first,
    this.second,
    this.third,
    this.visible = true,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'First': first?.toJson(),
      'Second': second?.toJson(),
      'Third': third?.toJson(),
      'Visible': visible,
    };
  }

  factory GiftstModel.fromJson(Map<String, dynamic> json) {
    return GiftstModel(
        isOpen: json['isOpen'] ?? false,
        tittle: json['title'] ?? "Gifts",
        icon: json['icon'] ?? "assets/icons/gift.png",
        first: GiftsKeyValue.fromJson(json['First']),
        second: GiftsKeyValue.fromJson(json['Second']),
        third: GiftsKeyValue.fromJson(json['Third']),
        visible: json['Visible']);
  }
}

class GiftsKeyValue {
  String? image;
  String? name;
  String? noRek;
  bool? visible;
  String? tittle;
  bool? isOpen;
  GiftsKeyValue({
    this.image = "ImageBca",
    this.name,
    this.noRek,
    this.visible = true,
    this.tittle,
    this.isOpen = true,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Image': image,
      'Name': name,
      'NoRek': noRek,
      'Visible': visible,
    };
  }

  factory GiftsKeyValue.fromJson(Map<String, dynamic> json) {
    return GiftsKeyValue(
      image: json['Image'] != null ? json['Image'] as String : "",
      name: json['Name'] != null ? json['Name'] as String : "",
      noRek: json['NoRek'] != null ? json['NoRek'] as String : "",
      visible: json['Visible'] != null ? json['Visible'] as bool : false,
      tittle: json['Tittle'] ?? "",
      isOpen: json['isOpen'] ?? false,
    );
  }
}
