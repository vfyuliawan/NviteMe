import 'dart:convert';

import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_detail_sample.dart';

class ModelResponseCreateProject {
  String code;
  String message;
  String messageError;
  ResultModelResponseDetailSample result;

  ModelResponseCreateProject({
    required this.code,
    required this.message,
    required this.messageError,
    required this.result,
  });

  ModelResponseCreateProject copyWith({
    String? code,
    String? message,
    String? messageError,
    ResultModelResponseDetailSample? result,
  }) =>
      ModelResponseCreateProject(
        code: code ?? this.code,
        message: message ?? this.message,
        messageError: messageError ?? this.messageError,
        result: result ?? this.result,
      );

  factory ModelResponseCreateProject.fromRawJson(String str) =>
      ModelResponseCreateProject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelResponseCreateProject.fromJson(Map<String, dynamic> json) =>
      ModelResponseCreateProject(
        code: json["code"],
        message: json["message"],
        messageError: json["messageError"] ?? "",
        result: ResultModelResponseDetailSample.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "messageError": messageError,
        "result": result.toJson(),
      };
}

class Result {
  String title;
  DateTime countdown;
  Cover hero;
  Cover home;
  Cover cover;
  Theme theme;
  InfoAcara infoAcara;
  BraidInfo braidInfo;
  ResultStory story;
  Galery galery;
  ResultGift gift;

  Result({
    required this.title,
    required this.countdown,
    required this.hero,
    required this.home,
    required this.cover,
    required this.theme,
    required this.infoAcara,
    required this.braidInfo,
    required this.story,
    required this.galery,
    required this.gift,
  });

  Result copyWith({
    String? title,
    DateTime? countdown,
    Cover? hero,
    Cover? home,
    Cover? cover,
    Theme? theme,
    InfoAcara? infoAcara,
    BraidInfo? braidInfo,
    ResultStory? story,
    Galery? galery,
    ResultGift? gift,
  }) =>
      Result(
        title: title ?? this.title,
        countdown: countdown ?? this.countdown,
        hero: hero ?? this.hero,
        home: home ?? this.home,
        cover: cover ?? this.cover,
        theme: theme ?? this.theme,
        infoAcara: infoAcara ?? this.infoAcara,
        braidInfo: braidInfo ?? this.braidInfo,
        story: story ?? this.story,
        galery: galery ?? this.galery,
        gift: gift ?? this.gift,
      );

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["title"],
        countdown: DateTime.parse(json["countdown"]),
        hero: Cover.fromJson(json["hero"]),
        home: Cover.fromJson(json["home"]),
        cover: Cover.fromJson(json["cover"]),
        theme: Theme.fromJson(json["theme"]),
        infoAcara: InfoAcara.fromJson(json["infoAcara"]),
        braidInfo: BraidInfo.fromJson(json["braidInfo"]),
        story: ResultStory.fromJson(json["story"]),
        galery: Galery.fromJson(json["galery"]),
        gift: ResultGift.fromJson(json["gift"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "countdown": countdown.toIso8601String(),
        "hero": hero.toJson(),
        "home": home.toJson(),
        "cover": cover.toJson(),
        "theme": theme.toJson(),
        "infoAcara": infoAcara.toJson(),
        "braidInfo": braidInfo.toJson(),
        "story": story.toJson(),
        "galery": galery.toJson(),
        "gift": gift.toJson(),
      };
}

class BraidInfo {
  Male male;
  Male female;
  bool isShow;

  BraidInfo({
    required this.male,
    required this.female,
    required this.isShow,
  });

  BraidInfo copyWith({
    Male? male,
    Male? female,
    bool? isShow,
  }) =>
      BraidInfo(
        male: male ?? this.male,
        female: female ?? this.female,
        isShow: isShow ?? this.isShow,
      );

  factory BraidInfo.fromRawJson(String str) =>
      BraidInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BraidInfo.fromJson(Map<String, dynamic> json) => BraidInfo(
        male: Male.fromJson(json["male"]),
        female: Male.fromJson(json["female"]),
        isShow: json["isShow"],
      );

  Map<String, dynamic> toJson() => {
        "male": male.toJson(),
        "female": female.toJson(),
        "isShow": isShow,
      };
}

class Male {
  String name;
  String image;
  String mom;
  String dad;

  Male({
    required this.name,
    required this.image,
    required this.mom,
    required this.dad,
  });

  Male copyWith({
    String? name,
    String? image,
    String? mom,
    String? dad,
  }) =>
      Male(
        name: name ?? this.name,
        image: image ?? this.image,
        mom: mom ?? this.mom,
        dad: dad ?? this.dad,
      );

  factory Male.fromRawJson(String str) => Male.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Male.fromJson(Map<String, dynamic> json) => Male(
        name: json["name"],
        image: json["image"],
        mom: json["mom"],
        dad: json["dad"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "mom": mom,
        "dad": dad,
      };
}

class Cover {
  String title;
  String img;
  DateTime date;
  bool isShow;
  String quotes;

  Cover({
    required this.title,
    required this.img,
    required this.date,
    required this.isShow,
    required this.quotes,
  });

  Cover copyWith({
    String? title,
    String? img,
    DateTime? date,
    bool? isShow,
    String? quotes,
  }) =>
      Cover(
        title: title ?? this.title,
        img: img ?? this.img,
        date: date ?? this.date,
        isShow: isShow ?? this.isShow,
        quotes: quotes ?? this.quotes,
      );

  factory Cover.fromRawJson(String str) => Cover.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cover.fromJson(Map<String, dynamic> json) => Cover(
        title: json["title"],
        img: json["img"],
        date: DateTime.parse(json["date"]),
        isShow: json["isShow"],
        quotes: json["quotes"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "img": img,
        "date": date.toIso8601String(),
        "isShow": isShow,
        "quotes": quotes,
      };
}

class Galery {
  List<String> galeries;
  bool isShow;

  Galery({
    required this.galeries,
    required this.isShow,
  });

  Galery copyWith({
    List<String>? galeries,
    bool? isShow,
  }) =>
      Galery(
        galeries: galeries ?? this.galeries,
        isShow: isShow ?? this.isShow,
      );

  factory Galery.fromRawJson(String str) => Galery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Galery.fromJson(Map<String, dynamic> json) => Galery(
        galeries: List<String>.from(json["galeries"].map((x) => x)),
        isShow: json["isShow"],
      );

  Map<String, dynamic> toJson() => {
        "galeries": List<dynamic>.from(galeries.map((x) => x)),
        "isShow": isShow,
      };
}

class ResultGift {
  List<GiftElement> gifts;
  bool isShow;

  ResultGift({
    required this.gifts,
    required this.isShow,
  });

  ResultGift copyWith({
    List<GiftElement>? gifts,
    bool? isShow,
  }) =>
      ResultGift(
        gifts: gifts ?? this.gifts,
        isShow: isShow ?? this.isShow,
      );

  factory ResultGift.fromRawJson(String str) =>
      ResultGift.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultGift.fromJson(Map<String, dynamic> json) => ResultGift(
        gifts: List<GiftElement>.from(
            json["gifts"].map((x) => GiftElement.fromJson(x))),
        isShow: json["isShow"],
      );

  Map<String, dynamic> toJson() => {
        "gifts": List<dynamic>.from(gifts.map((x) => x.toJson())),
        "isShow": isShow,
      };
}

class GiftElement {
  String image;
  String name;
  String noRek;

  GiftElement({
    required this.image,
    required this.name,
    required this.noRek,
  });

  GiftElement copyWith({
    String? image,
    String? name,
    String? noRek,
  }) =>
      GiftElement(
        image: image ?? this.image,
        name: name ?? this.name,
        noRek: noRek ?? this.noRek,
      );

  factory GiftElement.fromRawJson(String str) =>
      GiftElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GiftElement.fromJson(Map<String, dynamic> json) => GiftElement(
        image: json["image"],
        name: json["name"],
        noRek: json["noRek"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "noRek": noRek,
      };
}

class InfoAcara {
  Akad akad;
  Resepsi resepsi;

  InfoAcara({
    required this.akad,
    required this.resepsi,
  });

  InfoAcara copyWith({
    Akad? akad,
    Resepsi? resepsi,
  }) =>
      InfoAcara(
        akad: akad ?? this.akad,
        resepsi: resepsi ?? this.resepsi,
      );

  factory InfoAcara.fromRawJson(String str) =>
      InfoAcara.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InfoAcara.fromJson(Map<String, dynamic> json) => InfoAcara(
        akad: Akad.fromJson(json["akad"]),
        resepsi: Resepsi.fromJson(json["resepsi"]),
      );

  Map<String, dynamic> toJson() => {
        "akad": akad.toJson(),
        "resepsi": resepsi.toJson(),
      };
}

class Akad {
  String titleAkad;
  String mapAkad;
  String lokasiAkad;
  DateTime dateAkad;
  String imageAkad;

  Akad({
    required this.titleAkad,
    required this.mapAkad,
    required this.lokasiAkad,
    required this.dateAkad,
    required this.imageAkad,
  });

  Akad copyWith({
    String? titleAkad,
    String? mapAkad,
    String? lokasiAkad,
    DateTime? dateAkad,
    String? imageAkad,
  }) =>
      Akad(
        titleAkad: titleAkad ?? this.titleAkad,
        mapAkad: mapAkad ?? this.mapAkad,
        lokasiAkad: lokasiAkad ?? this.lokasiAkad,
        dateAkad: dateAkad ?? this.dateAkad,
        imageAkad: imageAkad ?? this.imageAkad,
      );

  factory Akad.fromRawJson(String str) => Akad.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Akad.fromJson(Map<String, dynamic> json) => Akad(
        titleAkad: json["titleAkad"],
        mapAkad: json["mapAkad"],
        lokasiAkad: json["lokasiAkad"],
        dateAkad: DateTime.parse(json["dateAkad"]),
        imageAkad: json["imageAkad"],
      );

  Map<String, dynamic> toJson() => {
        "titleAkad": titleAkad,
        "mapAkad": mapAkad,
        "lokasiAkad": lokasiAkad,
        "dateAkad": dateAkad.toIso8601String(),
        "imageAkad": imageAkad,
      };
}

class Resepsi {
  String titleResepsi;
  String mapResepsi;
  String lokasiResepsi;
  DateTime dateResepsi;
  String imageResepsi;

  Resepsi({
    required this.titleResepsi,
    required this.mapResepsi,
    required this.lokasiResepsi,
    required this.dateResepsi,
    required this.imageResepsi,
  });

  Resepsi copyWith({
    String? titleResepsi,
    String? mapResepsi,
    String? lokasiResepsi,
    DateTime? dateResepsi,
    String? imageResepsi,
  }) =>
      Resepsi(
        titleResepsi: titleResepsi ?? this.titleResepsi,
        mapResepsi: mapResepsi ?? this.mapResepsi,
        lokasiResepsi: lokasiResepsi ?? this.lokasiResepsi,
        dateResepsi: dateResepsi ?? this.dateResepsi,
        imageResepsi: imageResepsi ?? this.imageResepsi,
      );

  factory Resepsi.fromRawJson(String str) => Resepsi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Resepsi.fromJson(Map<String, dynamic> json) => Resepsi(
        titleResepsi: json["titleResepsi"],
        mapResepsi: json["mapResepsi"],
        lokasiResepsi: json["lokasiResepsi"],
        dateResepsi: DateTime.parse(json["dateResepsi"]),
        imageResepsi: json["imageResepsi"],
      );

  Map<String, dynamic> toJson() => {
        "titleResepsi": titleResepsi,
        "mapResepsi": mapResepsi,
        "lokasiResepsi": lokasiResepsi,
        "dateResepsi": dateResepsi.toIso8601String(),
        "imageResepsi": imageResepsi,
      };
}

class ResultStory {
  List<StoryElement> stories;
  bool isShow;

  ResultStory({
    required this.stories,
    required this.isShow,
  });

  ResultStory copyWith({
    List<StoryElement>? stories,
    bool? isShow,
  }) =>
      ResultStory(
        stories: stories ?? this.stories,
        isShow: isShow ?? this.isShow,
      );

  factory ResultStory.fromRawJson(String str) =>
      ResultStory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultStory.fromJson(Map<String, dynamic> json) => ResultStory(
        stories: List<StoryElement>.from(
            json["stories"].map((x) => StoryElement.fromJson(x))),
        isShow: json["isShow"],
      );

  Map<String, dynamic> toJson() => {
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
        "isShow": isShow,
      };
}

class StoryElement {
  String title;
  String text;
  String image;
  DateTime date;

  StoryElement({
    required this.title,
    required this.text,
    required this.image,
    required this.date,
  });

  StoryElement copyWith({
    String? title,
    String? text,
    String? image,
    DateTime? date,
  }) =>
      StoryElement(
        title: title ?? this.title,
        text: text ?? this.text,
        image: image ?? this.image,
        date: date ?? this.date,
      );

  factory StoryElement.fromRawJson(String str) =>
      StoryElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoryElement.fromJson(Map<String, dynamic> json) => StoryElement(
        title: json["title"],
        text: json["text"],
        image: json["image"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
        "image": image,
        "date": date.toIso8601String(),
      };
}

class Theme {
  String slug;
  String alamat;
  String embeded;
  String theme;
  String music;

  Theme({
    required this.slug,
    required this.alamat,
    required this.embeded,
    required this.theme,
    required this.music,
  });

  Theme copyWith({
    String? slug,
    String? alamat,
    String? embeded,
    String? theme,
    String? music,
  }) =>
      Theme(
        slug: slug ?? this.slug,
        alamat: alamat ?? this.alamat,
        embeded: embeded ?? this.embeded,
        theme: theme ?? this.theme,
        music: music ?? this.music,
      );

  factory Theme.fromRawJson(String str) => Theme.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Theme.fromJson(Map<String, dynamic> json) => Theme(
        slug: json["slug"],
        alamat: json["alamat"],
        embeded: json["embeded"],
        theme: json["theme"],
        music: json["music"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "alamat": alamat,
        "embeded": embeded,
        "theme": theme,
        "music": music,
      };
}
