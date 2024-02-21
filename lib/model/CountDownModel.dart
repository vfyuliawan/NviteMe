// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class CountDownModel {
  bool? isOpen;
  String? tittle;
  String? icon;
  Timestamp? date;
  bool? visible;
  CountDownModel({
    Timestamp? date,
    this.visible = true,
    this.isOpen = true,
    this.tittle = "CountDown",
    this.icon = "assets/icons/countdown.png",
  }) : date = date ?? Timestamp.now();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Date': date ?? Timestamp.now(),
      'Visible': visible ?? false,
    };
  }

  factory CountDownModel.fromJson(Map<String, dynamic> json) {
    return CountDownModel(
      date: json["Date"] ?? Timestamp.now(),
      visible: json['Visible'] as bool,
      isOpen: json['isOpen'] ?? false,
      tittle: json['title'] ?? "CountDown",
      icon: json['icon'] ?? "assets/icons/countdown.png",
    );
  }
}
