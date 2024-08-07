import 'dart:convert';

class ModelRequestCreateProject {
  String title;
  DateTime countdown;
  CoverResponse hero;
  HomeResponse home;
  CoverResponse cover;
  ThemeResponse theme;
  InfoAcarResponse infoAcara;
  BraidInfoResponse braidInfo;
  ModelRequestCreateProjectStory story;
  GaleryRequeset galery;
  ModelRequestCreateProjectGift gift;

  ModelRequestCreateProject({
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

  factory ModelRequestCreateProject.fromRawJson(String str) =>
      ModelRequestCreateProject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelRequestCreateProject.fromJson(Map<String, dynamic> json) =>
      ModelRequestCreateProject(
        title: json["title"],
        countdown: DateTime.parse(json["countdown"]),
        hero: CoverResponse.fromJson(json["hero"]),
        home: HomeResponse.fromJson(json["home"]),
        cover: CoverResponse.fromJson(json["cover"]),
        theme: ThemeResponse.fromJson(json["theme"]),
        infoAcara: InfoAcarResponse.fromJson(json["infoAcara"]),
        braidInfo: BraidInfoResponse.fromJson(json["braidInfo"]),
        story: ModelRequestCreateProjectStory.fromJson(json["story"]),
        galery: GaleryRequeset.fromJson(json["galery"]),
        gift: ModelRequestCreateProjectGift.fromJson(json["gift"]),
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

class BraidInfoResponse {
  MaleResponse male;
  MaleResponse female;
  bool isShow;

  BraidInfoResponse({
    required this.male,
    required this.female,
    required this.isShow,
  });

  factory BraidInfoResponse.fromRawJson(String str) =>
      BraidInfoResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BraidInfoResponse.fromJson(Map<String, dynamic> json) =>
      BraidInfoResponse(
        male: MaleResponse.fromJson(json["male"]),
        female: MaleResponse.fromJson(json["female"]),
        isShow: json["isShow"],
      );

  Map<String, dynamic> toJson() => {
        "male": male.toJson(),
        "female": female.toJson(),
        "isShow": isShow,
      };
}

class MaleResponse {
  String name;
  String mom;
  String dad;
  String photo;

  MaleResponse({
    required this.name,
    required this.mom,
    required this.dad,
    required this.photo,
  });

  factory MaleResponse.fromRawJson(String str) =>
      MaleResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MaleResponse.fromJson(Map<String, dynamic> json) => MaleResponse(
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

class CoverResponse {
  String img;
  bool isShow;

  CoverResponse({
    required this.img,
    required this.isShow,
  });

  factory CoverResponse.fromRawJson(String str) =>
      CoverResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CoverResponse.fromJson(Map<String, dynamic> json) => CoverResponse(
        img: json["img"],
        isShow: json["isShow"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "isShow": isShow,
      };
}

class GaleryRequeset {
  List<String> galeries;
  bool isShow;

  GaleryRequeset({
    required this.galeries,
    required this.isShow,
  });

  factory GaleryRequeset.fromRawJson(String str) =>
      GaleryRequeset.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GaleryRequeset.fromJson(Map<String, dynamic> json) => GaleryRequeset(
        galeries: List<String>.from(json["galeries"].map((x) => x)),
        isShow: json["isShow"],
      );

  Map<String, dynamic> toJson() => {
        "galeries": List<dynamic>.from(galeries.map((x) => x)),
        "isShow": isShow,
      };
}

class ModelRequestCreateProjectGift {
  List<GiftElementReq> gifts;
  bool isShow;

  ModelRequestCreateProjectGift({
    required this.gifts,
    required this.isShow,
  });

  factory ModelRequestCreateProjectGift.fromRawJson(String str) =>
      ModelRequestCreateProjectGift.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelRequestCreateProjectGift.fromJson(Map<String, dynamic> json) =>
      ModelRequestCreateProjectGift(
        gifts: List<GiftElementReq>.from(
            json["gifts"].map((x) => GiftElementReq.fromJson(x))),
        isShow: json["isShow"],
      );

  Map<String, dynamic> toJson() => {
        "gifts": List<dynamic>.from(gifts.map((x) => x.toJson())),
        "isShow": isShow,
      };
}

class GiftElementReq {
  String image;
  String name;
  String noRek;

  GiftElementReq({
    required this.image,
    required this.name,
    required this.noRek,
  });

  factory GiftElementReq.fromRawJson(String str) =>
      GiftElementReq.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GiftElementReq.fromJson(Map<String, dynamic> json) => GiftElementReq(
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

class HomeResponse {
  String quotes;
  String img;
  bool isShow;

  HomeResponse({
    required this.quotes,
    required this.img,
    required this.isShow,
  });

  factory HomeResponse.fromRawJson(String str) =>
      HomeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
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

class InfoAcarResponse {
  AkadResponse akad;
  ResepsiResponse resepsi;

  InfoAcarResponse({
    required this.akad,
    required this.resepsi,
  });

  factory InfoAcarResponse.fromRawJson(String str) =>
      InfoAcarResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InfoAcarResponse.fromJson(Map<String, dynamic> json) =>
      InfoAcarResponse(
        akad: AkadResponse.fromJson(json["akad"]),
        resepsi: ResepsiResponse.fromJson(json["resepsi"]),
      );

  Map<String, dynamic> toJson() => {
        "akad": akad.toJson(),
        "resepsi": resepsi.toJson(),
      };
}

class AkadResponse {
  String titleAkad;
  String mapAkad;
  String imgAkad;
  String lokasiAkad;
  DateTime dateAkad;

  AkadResponse({
    required this.titleAkad,
    required this.mapAkad,
    required this.imgAkad,
    required this.lokasiAkad,
    required this.dateAkad,
  });

  factory AkadResponse.fromRawJson(String str) =>
      AkadResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AkadResponse.fromJson(Map<String, dynamic> json) => AkadResponse(
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

class ResepsiResponse {
  String titleResepsi;
  String mapResepsi;
  String imgResepsi;
  String lokasiResepsi;
  DateTime dateResepsi;

  ResepsiResponse({
    required this.titleResepsi,
    required this.mapResepsi,
    required this.imgResepsi,
    required this.lokasiResepsi,
    required this.dateResepsi,
  });

  factory ResepsiResponse.fromRawJson(String str) =>
      ResepsiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResepsiResponse.fromJson(Map<String, dynamic> json) =>
      ResepsiResponse(
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

class ModelRequestCreateProjectStory {
  List<StoryElementReq> stories;
  bool isShow;

  ModelRequestCreateProjectStory({
    required this.stories,
    required this.isShow,
  });

  factory ModelRequestCreateProjectStory.fromRawJson(String str) =>
      ModelRequestCreateProjectStory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelRequestCreateProjectStory.fromJson(Map<String, dynamic> json) =>
      ModelRequestCreateProjectStory(
        stories: List<StoryElementReq>.from(
            json["stories"].map((x) => StoryElementReq.fromJson(x))),
        isShow: json["isShow"],
      );

  Map<String, dynamic> toJson() => {
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
        "isShow": isShow,
      };
}

class StoryElementReq {
  String title;
  String text;
  String image;
  DateTime date;

  StoryElementReq({
    required this.title,
    required this.text,
    required this.image,
    required this.date,
  });

  factory StoryElementReq.fromRawJson(String str) =>
      StoryElementReq.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoryElementReq.fromJson(Map<String, dynamic> json) =>
      StoryElementReq(
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

class ThemeResponse {
  String slug;
  String alamat;
  String embeded;
  String theme;
  String music;

  ThemeResponse({
    required this.slug,
    required this.alamat,
    required this.embeded,
    required this.theme,
    required this.music,
  });

  factory ThemeResponse.fromRawJson(String str) =>
      ThemeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ThemeResponse.fromJson(Map<String, dynamic> json) => ThemeResponse(
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
