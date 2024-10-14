// To parse this JSON data, do
//
//     final modelRequestCreateUndangan = modelRequestCreateUndanganFromJson(jsonString);

import 'dart:convert';

ModelRequestCreateUndangan modelRequestCreateUndanganFromJson(String str) =>
    ModelRequestCreateUndangan.fromJson(json.decode(str));

String modelRequestCreateUndanganToJson(ModelRequestCreateUndangan data) =>
    json.encode(data.toJson());

class ModelRequestCreateUndangan {
  String title;
  DateTime countdown;
  Cover hero;
  Home home;
  Cover cover;
  ThemeProj theme;
  InfoAcara infoAcara;
  BraidInfo braidInfo;
  ModelRequestCreateUndanganStory story;
  Galery galery;
  ModelRequestCreateUndanganGift gift;

  ModelRequestCreateUndangan({
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

  ModelRequestCreateUndangan copyWith({
    String? title,
    DateTime? countdown,
    Cover? hero,
    Home? home,
    Cover? cover,
    ThemeProj? theme,
    InfoAcara? infoAcara,
    BraidInfo? braidInfo,
    ModelRequestCreateUndanganStory? story,
    Galery? galery,
    ModelRequestCreateUndanganGift? gift,
  }) =>
      ModelRequestCreateUndangan(
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

  factory ModelRequestCreateUndangan.fromJson(Map<String, dynamic> json) =>
      ModelRequestCreateUndangan(
        title: json["title"],
        countdown: DateTime.parse(json["countdown"]),
        hero: Cover.fromJson(json["hero"]),
        home: Home.fromJson(json["home"]),
        cover: Cover.fromJson(json["cover"]),
        theme: ThemeProj.fromJson(json["theme"]),
        infoAcara: InfoAcara.fromJson(json["infoAcara"]),
        braidInfo: BraidInfo.fromJson(json["braidInfo"]),
        story: ModelRequestCreateUndanganStory.fromJson(json["story"]),
        galery: Galery.fromJson(json["galery"]),
        gift: ModelRequestCreateUndanganGift.fromJson(json["gift"]),
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
  String mom;
  String dad;
  String photo;

  Male({
    required this.name,
    required this.mom,
    required this.dad,
    required this.photo,
  });

  Male copyWith({
    String? name,
    String? mom,
    String? dad,
    String? photo,
  }) =>
      Male(
        name: name ?? this.name,
        mom: mom ?? this.mom,
        dad: dad ?? this.dad,
        photo: photo ?? this.photo,
      );

  factory Male.fromJson(Map<String, dynamic> json) => Male(
        name: json["name"],
        mom: json["mom"],
        dad: json["dad"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mom": mom,
        "dad": dad,
        "photo": photo,
      };
}

class Cover {
  String img;
  bool isShow;

  Cover({
    required this.img,
    required this.isShow,
  });

  Cover copyWith({
    String? img,
    bool? isShow,
  }) =>
      Cover(
        img: img ?? this.img,
        isShow: isShow ?? this.isShow,
      );

  factory Cover.fromJson(Map<String, dynamic> json) => Cover(
        img: json["img"],
        isShow: json["isShow"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "isShow": isShow,
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

  factory Galery.fromJson(Map<String, dynamic> json) => Galery(
        galeries: List<String>.from(json["galeries"].map((x) => x)),
        isShow: json["isShow"],
      );

  Map<String, dynamic> toJson() => {
        "galeries": List<dynamic>.from(galeries.map((x) => x)),
        "isShow": isShow,
      };
}

class ModelRequestCreateUndanganGift {
  List<GiftElement> gifts;
  bool isShow;

  ModelRequestCreateUndanganGift({
    required this.gifts,
    required this.isShow,
  });

  ModelRequestCreateUndanganGift copyWith({
    List<GiftElement>? gifts,
    bool? isShow,
  }) =>
      ModelRequestCreateUndanganGift(
        gifts: gifts ?? this.gifts,
        isShow: isShow ?? this.isShow,
      );

  factory ModelRequestCreateUndanganGift.fromJson(Map<String, dynamic> json) =>
      ModelRequestCreateUndanganGift(
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

class Home {
  String quotes;
  String img;
  bool isShow;

  Home({
    required this.quotes,
    required this.img,
    required this.isShow,
  });

  Home copyWith({
    String? quotes,
    String? img,
    bool? isShow,
  }) =>
      Home(
        quotes: quotes ?? this.quotes,
        img: img ?? this.img,
        isShow: isShow ?? this.isShow,
      );

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        quotes: json["quotes"],
        img: json["img"],
        isShow: json["isShow"],
      );

  Map<String, dynamic> toJson() => {
        "quotes": quotes,
        "img": img,
        "isShow": isShow,
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
  String imgAkad;
  String lokasiAkad;
  DateTime dateAkad;

  Akad({
    required this.titleAkad,
    required this.mapAkad,
    required this.imgAkad,
    required this.lokasiAkad,
    required this.dateAkad,
  });

  Akad copyWith({
    String? titleAkad,
    String? mapAkad,
    String? imgAkad,
    String? lokasiAkad,
    DateTime? dateAkad,
  }) =>
      Akad(
        titleAkad: titleAkad ?? this.titleAkad,
        mapAkad: mapAkad ?? this.mapAkad,
        imgAkad: imgAkad ?? this.imgAkad,
        lokasiAkad: lokasiAkad ?? this.lokasiAkad,
        dateAkad: dateAkad ?? this.dateAkad,
      );

  factory Akad.fromJson(Map<String, dynamic> json) => Akad(
        titleAkad: json["titleAkad"],
        mapAkad: json["mapAkad"],
        imgAkad: json["imgAkad"],
        lokasiAkad: json["lokasiAkad"],
        dateAkad: DateTime.parse(json["dateAkad"]),
      );

  Map<String, dynamic> toJson() => {
        "titleAkad": titleAkad,
        "mapAkad": mapAkad,
        "imgAkad": imgAkad,
        "lokasiAkad": lokasiAkad,
        "dateAkad": dateAkad.toIso8601String(),
      };
}

class Resepsi {
  String titleResepsi;
  String mapResepsi;
  String imgResepsi;
  String lokasiResepsi;
  DateTime dateResepsi;

  Resepsi({
    required this.titleResepsi,
    required this.mapResepsi,
    required this.imgResepsi,
    required this.lokasiResepsi,
    required this.dateResepsi,
  });

  Resepsi copyWith({
    String? titleResepsi,
    String? mapResepsi,
    String? imgResepsi,
    String? lokasiResepsi,
    DateTime? dateResepsi,
  }) =>
      Resepsi(
        titleResepsi: titleResepsi ?? this.titleResepsi,
        mapResepsi: mapResepsi ?? this.mapResepsi,
        imgResepsi: imgResepsi ?? this.imgResepsi,
        lokasiResepsi: lokasiResepsi ?? this.lokasiResepsi,
        dateResepsi: dateResepsi ?? this.dateResepsi,
      );

  factory Resepsi.fromJson(Map<String, dynamic> json) => Resepsi(
        titleResepsi: json["titleResepsi"],
        mapResepsi: json["mapResepsi"],
        imgResepsi: json["imgResepsi"],
        lokasiResepsi: json["lokasiResepsi"],
        dateResepsi: DateTime.parse(json["dateResepsi"]),
      );

  Map<String, dynamic> toJson() => {
        "titleResepsi": titleResepsi,
        "mapResepsi": mapResepsi,
        "imgResepsi": imgResepsi,
        "lokasiResepsi": lokasiResepsi,
        "dateResepsi": dateResepsi.toIso8601String(),
      };
}

class ModelRequestCreateUndanganStory {
  List<StoryElement> stories;
  bool isShow;

  ModelRequestCreateUndanganStory({
    required this.stories,
    required this.isShow,
  });

  ModelRequestCreateUndanganStory copyWith({
    List<StoryElement>? stories,
    bool? isShow,
  }) =>
      ModelRequestCreateUndanganStory(
        stories: stories ?? this.stories,
        isShow: isShow ?? this.isShow,
      );

  factory ModelRequestCreateUndanganStory.fromJson(Map<String, dynamic> json) =>
      ModelRequestCreateUndanganStory(
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

class ThemeProj {
  String slug;
  String alamat;
  String embeded;
  String theme;
  String music;

  ThemeProj({
    required this.slug,
    required this.alamat,
    required this.embeded,
    required this.theme,
    required this.music,
  });

  ThemeProj copyWith({
    String? slug,
    String? alamat,
    String? embeded,
    String? theme,
    String? music,
  }) =>
      ThemeProj(
        slug: slug ?? this.slug,
        alamat: alamat ?? this.alamat,
        embeded: embeded ?? this.embeded,
        theme: theme ?? this.theme,
        music: music ?? this.music,
      );

  factory ThemeProj.fromJson(Map<String, dynamic> json) => ThemeProj(
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
