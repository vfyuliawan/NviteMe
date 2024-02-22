// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/AddProjectController.dart';
import 'package:nvite_me/model/CountDownModel.dart';
import 'package:nvite_me/model/CoverModel.dart';
import 'package:nvite_me/model/GaleryModel.dart';
import 'package:nvite_me/model/GiftsModel.dart';
import 'package:nvite_me/model/HeroModel.dart';
import 'package:nvite_me/model/HomeModel.dart';
import 'package:nvite_me/model/InfoAcaraModel.dart';
import 'package:nvite_me/model/MaleFemaleModel.dart';
import 'package:nvite_me/model/OurStoryModel.dart';
import 'package:nvite_me/model/UserIdModel.dart';
import 'package:nvite_me/screen/AddUser/AddCard/CountDownAddCard.dart';
import 'package:nvite_me/screen/AddUser/AddCard/CoverAddCard.dart';
import 'package:nvite_me/screen/AddUser/AddCard/GaleryAddCard.dart';
import 'package:nvite_me/screen/AddUser/AddCard/GiftsAddCard.dart';
import 'package:nvite_me/screen/AddUser/AddCard/HeroAddCard.dart';
import 'package:nvite_me/screen/AddUser/AddCard/HomeAddCard.dart';
import 'package:nvite_me/screen/AddUser/AddCard/InfoAcaraAddCard.dart';
import 'package:nvite_me/screen/AddUser/AddCard/MeleFemaleAddCard.dart';
import 'package:nvite_me/screen/AddUser/AddCard/OurStoryAddCard.dart';
import 'package:nvite_me/screen/AddUser/AddCard/ThemeAddCard.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late UserIdModel userId = UserIdModel();
  late bool enableDropdown = false;
  late bool enableApply = false;
  late bool loading = false;

  @override
  void initState() {
    cekallValidation();
    super.initState();
  }

  bool? validateTheme() {
    late List<bool> validate = [];
    if (userId.slug == null || userId.slug!.isEmpty) {
      validate.add(true);
    }
    if (userId.themeSong == null || userId.themeSong!.isEmpty) {
      validate.add(true);
    }
    if (userId.themeName == null || userId.themeName!.isEmpty) {
      validate.add(true);
    }
    if (validate.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool? validateCover() {
    List<bool> validate = [];
    if (userId.cover != null) {
      if (userId.cover!.titleCover == null ||
          userId.cover!.titleCover!.isEmpty) {
        validate.add(true);
      }
      if (userId.cover!.imgCover == null || userId.cover!.imgCover!.isEmpty) {
        validate.add(true);
      }
      return validate.isEmpty;
    } else {
      return null;
    }
  }

  bool? validateHome() {
    List<bool> validate = [];
    if (userId.home != null) {
      if (userId.home!.homeTittle == null || userId.home!.homeTittle!.isEmpty) {
        validate.add(true);
      }
      if (userId.home!.homeQuotes == null || userId.home!.homeQuotes!.isEmpty) {
        validate.add(true);
      }
      if (userId.home!.homeImg == null || userId.home!.homeImg!.isEmpty) {
        validate.add(true);
      }
      return validate.isEmpty;
    } else {
      return null;
    }
  }

  bool? validateHero() {
    List<bool> validate = [];
    if (userId.hero != null) {
      if (userId.hero!.heroTittle == null || userId.hero!.heroTittle!.isEmpty) {
        validate.add(true);
      }
      if (userId.hero!.heroImg == null || userId.hero!.heroImg!.isEmpty) {
        validate.add(true);
      }
      return validate.isEmpty;
    } else {
      return null;
    }
  }

  bool? validateInfo() {
    List<bool> validate = [];
    if (userId.infoAcara != null) {
      if (userId.infoAcara!.infoAcara != null) {
        validate = userId.infoAcara!.infoAcara!.map((item) {
          bool isValid = true;
          if (item.judul == null || item.judul!.isEmpty) {
            isValid = false;
          }
          if (item.map == null || item.map!.isEmpty) {
            isValid = false;
          }
          if (item.place == null || item.place!.isEmpty) {
            isValid = false;
          }
          if (item.photo == null || item.photo!.isEmpty) {
            isValid = false;
          }
          return isValid;
        }).toList();
        return validate.first && validate.last ? true : null;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  bool? validateMaleFemale() {
    List<bool> validate = [];
    if (userId.maleFemale != null &&
        userId.maleFemale!.male != null &&
        userId.maleFemale!.female != null) {
      if (userId.maleFemale!.male!.name == null ||
          userId.maleFemale!.male!.name!.isEmpty) {
        validate.add(true);
      }
      if (userId.maleFemale!.male!.ayah == null ||
          userId.maleFemale!.male!.ayah!.isEmpty) {
        validate.add(true);
      }
      if (userId.maleFemale!.male!.ibu == null ||
          userId.maleFemale!.male!.ibu!.isEmpty) {
        validate.add(true);
      }
      if (userId.maleFemale!.male!.photo == null ||
          userId.maleFemale!.male!.photo!.isEmpty) {
        validate.add(true);
      }
      if (userId.maleFemale!.female!.name == null ||
          userId.maleFemale!.female!.name!.isEmpty) {
        validate.add(true);
      }
      if (userId.maleFemale!.female!.ayah == null ||
          userId.maleFemale!.female!.ayah!.isEmpty) {
        validate.add(true);
      }
      if (userId.maleFemale!.female!.ibu == null ||
          userId.maleFemale!.female!.ibu!.isEmpty) {
        validate.add(true);
      }
      if (userId.maleFemale!.female!.photo == null ||
          userId.maleFemale!.female!.photo!.isEmpty) {
        validate.add(true);
      }

      return validate.isEmpty;
    } else {
      return null;
    }
  }

  bool? validateOurUser() {
    List<bool> validate = [];
    if (userId.ourStory != null &&
        userId.ourStory!.first != null &&
        userId.ourStory!.second != null &&
        userId.ourStory!.third != null) {
      if (userId.ourStory!.first!.tittle == null ||
          userId.ourStory!.first!.tittle!.isEmpty) {
        validate.add(true);
      }
      if (userId.ourStory!.first!.story == null ||
          userId.ourStory!.first!.story!.isEmpty) {
        validate.add(true);
      }
      if (userId.ourStory!.first!.photo == null ||
          userId.ourStory!.first!.photo!.isEmpty) {
        validate.add(true);
      }

      if (userId.ourStory!.second!.tittle == null ||
          userId.ourStory!.second!.tittle!.isEmpty) {
        validate.add(true);
      }
      if (userId.ourStory!.second!.story == null ||
          userId.ourStory!.second!.story!.isEmpty) {
        validate.add(true);
      }
      if (userId.ourStory!.second!.photo == null ||
          userId.ourStory!.second!.photo!.isEmpty) {
        validate.add(true);
      }

      if (userId.ourStory!.third!.tittle == null ||
          userId.ourStory!.third!.tittle!.isEmpty) {
        validate.add(true);
      }
      if (userId.ourStory!.third!.story == null ||
          userId.ourStory!.third!.story!.isEmpty) {
        validate.add(true);
      }
      if (userId.ourStory!.third!.photo == null ||
          userId.ourStory!.third!.photo!.isEmpty) {
        validate.add(true);
      }
      return validate.isEmpty;
    } else {
      return null;
    }
  }

  bool? validateGalery() {
    if (userId.galery != null) {
      if (userId.galery!.image!.isEmpty) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  void cekallValidation() {
    if (validateCover() == true &&
        validateTheme() == true &&
        validateHome() == true &&
        validateHero() == true &&
        validateInfo() == true &&
        validateMaleFemale() == true &&
        validateOurUser() == true &&
        validateGalery() == true) {
      setState(() {
        enableApply = true;
      });
    } else {
      setState(() {
        enableApply = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: !loading
          ? Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor:
                        !enableApply ? Colors.grey : Constans.secondaryColor),
                onPressed: () async {
                  if (enableApply) {
                    print(userId.toJson());
                    setState(() {
                      loading = true;
                    });
                    await AddProjectController()
                        .uploadDataToFirestore(userId)
                        .then((value) {
                      if (value) {
                        setState(() {
                          loading = false;
                        });
                        Alert(
                          context: context,
                          type: AlertType.success,
                          title: "Berhasil menambahkan Project",
                          style: AlertStyle(
                            titleStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            descStyle: TextStyle(fontSize: 16),
                          ),
                          desc: "Klik Perview untuk melihat perubahan.",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Oke",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              width: 120,
                            )
                          ],
                        ).show();
                      }
                    });
                  } else {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Gagal",
                      style: AlertStyle(
                        titleStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        descStyle: TextStyle(fontSize: 16),
                      ),
                      desc: "Pastikan Semua Form Telah Terisi.",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Oke",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          width: 120,
                        )
                      ],
                    ).show();
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add_to_home_screen_outlined,
                          color: Colors.white),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Apply',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      body: loading
          ? Container(
              decoration: BoxDecoration(
                color: Constans.secondaryColor,
              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: Constans.fourthColor,
                ),
              ),
            )
          : Column(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            color: Constans.secondaryColor,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            margin: const EdgeInsets.only(top: 35),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  // ignore: sized_box_for_whitespace
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Add Project",
                                  style: TextStyle(
                                    fontFamily: 'Pacifico',
                                    fontSize: 25,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                            height: 100,
                            margin: const EdgeInsets.only(top: 80),
                            decoration: BoxDecoration(
                                color: Constans.thirdColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                )),
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 24,
                                left: 10,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Create Your Project",
                                    style: TextStyle(
                                      fontFamily: "Pacifico",
                                      fontSize: 18,
                                      color: Constans.textColor,
                                    ),
                                  )
                                ],
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 160),
                          height: MediaQuery.of(context).size.height - 228,
                          decoration: BoxDecoration(
                              color: Constans.fourthColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              )),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  _formBody(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 90, right: 20),
                          alignment: Alignment.centerRight,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _formBody() {
    return Column(
      children: [
        ThemeAddCard(
          slug: userId.slug ?? "",
          song: userId.themeSong ?? Constans.listThemeSong.first,
          thema: userId.themeName ?? Constans.listTheme.first,
          guestBarcode: userId.guestBarcode ?? false,
          embeded: userId.embeded ?? "",
          onChange: (String? slug, String? themeSong, String? themeName,
              bool? guestBarcode, String embeded) {
            setState(() {
              userId.slug = slug;
              userId.themeName = themeName;
              userId.themeSong = themeSong;
              userId.guestBarcode = guestBarcode;
              userId.embeded = embeded;
            });
            cekallValidation();
          },
        ),
        CoverAddCard(
          slug: userId.slug ?? "",
          data: userId.cover ??
              CoverModel(
                icon: "assets/icons/cover-letter.png",
                tittle: "Cover & Footer",
                isOpen: true,
                date: Timestamp.now(),
              ),
          onCoverChanged: (CoverModel newCover) {
            setState(() {
              userId.cover = newCover;
              enableDropdown = true;
            });
            cekallValidation();
          },
        ),
        HomeAddCard(
          slug: userId.slug ?? "",
          data: userId.home ??
              HomeModel(
                icon: "assets/icons/homework.png",
                tittle: "Home",
                isOpen: true,
              ),
          onCoverChanged: (HomeModel newHome) {
            setState(() {
              userId.home = newHome;
            });
            cekallValidation();
          },
        ),
        HeroAddCard(
          data: userId.hero ??
              HeroModel(
                  icon: "assets/icons/Hero.png",
                  tittle: "Hero",
                  isOpen: true,
                  heroDate: Timestamp.now()),
          slug: userId.slug ?? "",
          onCoverChanged: (HeroModel newHero) {
            setState(() {
              userId.hero = newHero;
            });
            cekallValidation();
          },
        ),
        InfoAcaraAddCard(
          slug: userId.slug ?? "",
          data: userId.infoAcara ??
              InfoAcaraModel(
                icon: "assets/icons/info.png",
                tittle: "Info Acara",
                isOpen: true,
              ),
          onCoverChanged: (InfoAcaraModel newInfoAcara) {
            setState(() {
              userId.infoAcara = newInfoAcara;
            });
            cekallValidation();
          },
        ),
        MaleFemaleAddCard(
          slug: userId.slug ?? "",
          maleFemale: userId.maleFemale ??
              MaleFemaleModel(female: Male(), male: Male()),
          onCoverChanged: (MaleFemaleModel newMaleFemale) {
            setState(() {
              userId.maleFemale = newMaleFemale;
            });
            cekallValidation();
          },
        ),
        OurStoryAdd(
          slug: userId.slug ?? "",
          ourStory: userId.ourStory ??
              OurStoryModel(
                  first: KeyValueOuStory(),
                  second: KeyValueOuStory(),
                  third: KeyValueOuStory()),
          onCoverChanged: (OurStoryModel newStory) {
            setState(() {
              userId.ourStory = newStory;
            });
            cekallValidation();
          },
        ),
        GaleryAddCard(
          slug: userId.slug ?? "",
          ourGalery: userId.galery ?? GaleryModel(image: []),
          onCoverChanged: (GaleryModel newGalery) {
            setState(() {
              userId.galery = newGalery;
            });
            cekallValidation();
          },
        ),
        GiftsAddCard(
          slug: userId.slug ?? "",
          gifts: userId.gifts ??
              GiftstModel(
                first: GiftsKeyValue(),
                second: GiftsKeyValue(),
                third: GiftsKeyValue(),
              ),
          onCoverChanged: (GiftstModel newGifts) {
            setState(() {
              userId.gifts = newGifts;
            });
          },
        ),
        CountDownAddCard(
          slug: userId.slug ?? "",
          data: userId.countDown ?? CountDownModel(),
          onCoverChanged: (CountDownModel newCount) {
            setState(() {
              userId.countDown = newCount;
            });
          },
        ),
        SizedBox(
          height: 90,
        )
      ],
    );
  }
}
