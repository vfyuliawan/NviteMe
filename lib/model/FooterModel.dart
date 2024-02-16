import 'package:nvite_me/model/CoverModel.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FooterModel {
  String? image;
  String? name;
  String? qutes;
  FooterModel({
    String? image,
    String? name,
    this.qutes =
        "Merupakan suatu kehormatan dan kebahagiaan bagi kami, apabila Bapak/Ibu/Saudara/i berkenan hadir dan memberikan doa restu. Atas kehadiran dan doa restunya, kami mengucapkan terima kasih",
  })  : image = image ?? CoverModel().imgCover,
        name = name ?? CoverModel().titleCover;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Image': image,
      'Name': name,
      'Qutes':
          "Merupakan suatu kehormatan dan kebahagiaan bagi kami, apabila Bapak/Ibu/Saudara/i berkenan hadir dan memberikan doa restu. Atas kehadiran dan doa restunya, kami mengucapkan terima kasih.",
    };
  }

  factory FooterModel.fromMap(Map<String, dynamic> map) {
    return FooterModel(
      image: map['Image'] != null ? map['image'] as String : null,
      name: map['Name'] != null ? map['name'] as String : null,
      qutes: map['Qutes'] != null ? map['qutes'] as String : null,
    );
  }
}
