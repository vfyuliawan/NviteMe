import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/OurProjectController.dart';
import 'package:nvite_me/model/UserIdModel.dart';
import 'package:nvite_me/screen/Modul/CountDownCard.dart';
import 'package:nvite_me/screen/Modul/CoverCard.dart';
import 'package:nvite_me/screen/Modul/GaleryCard.dart';
import 'package:nvite_me/screen/Modul/GiftsCard.dart';
import 'package:nvite_me/screen/Modul/HeroCard.dart';
import 'package:nvite_me/screen/Modul/HomeCard.dart';
import 'package:nvite_me/screen/Modul/InfoAcaraCard.dart';
import 'package:nvite_me/screen/Modul/MeleFemale.dart';
import 'package:nvite_me/screen/Modul/OurStoryCard.dart';
import 'package:nvite_me/screen/Modul/ThemeSlugCard.dart';
import 'package:nvite_me/screen/WebView.dart';

class DetailUserScreen extends StatefulWidget {
  final UserIdModel detailUser;
  const DetailUserScreen({Key? key, required this.detailUser})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailUserScreenState createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  TextEditingController slugController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<UserIdModel>(
            stream: OurProjectController().getData(widget.detailUser.slug!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error Ditemukan"),
                );
              } else if (snapshot.data == null) {
                return const Center(
                  child: Text("Tidak Ada Data"),
                );
              } else {
                UserIdModel dataSnapShoot = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          // WidgetCountUser(),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        "Project Detail",
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
                                height: 300,
                                margin: const EdgeInsets.only(top: 80),
                                decoration: BoxDecoration(
                                    color: Constans.thirdColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                    )),
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  fit: StackFit.loose,
                                  alignment: Alignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        widget.detailUser.themeName!.isNotEmpty
                                            ? Image.asset(
                                                'assets/images/theme/${widget.detailUser.themeName}.png',
                                                width: 250,
                                                height: 200,
                                              )
                                            : Image.network(
                                                'https://placehold.co/250x250/black/white'),
                                        Text(
                                          "You Using Theme ${widget.detailUser.themeName}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Pacifico',
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.bold,
                                              color: Constans.secondaryColor),
                                        )
                                      ],
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => WebView(
                                                      slug: widget
                                                          .detailUser.slug!,
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          width: 100,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Constans.secondaryColor,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10))),
                                          child: const Row(children: [
                                            Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "Perview",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: 'Roboto',
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 310),
                                height:
                                    MediaQuery.of(context).size.height - 310,
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
                                        _formBody(dataSnapShoot),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 90, right: 20),
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
            }));
  }

  Widget _formBody(UserIdModel dataSnapShoot) {
    return Column(
      children: [
        ThemeSlugCard(
          embeded: dataSnapShoot.embeded!,
          slug: dataSnapShoot.slug,
          thema: dataSnapShoot.themeName,
          guestBarcode: dataSnapShoot.guestBarcode,
          song: dataSnapShoot.themeSong,
          guest: dataSnapShoot.guest!,
        ),
        const SizedBox(
          height: 10,
        ),
        CoverTextFieldCard(
          data: dataSnapShoot.cover,
          slug: dataSnapShoot.slug!,
        ),
        HomeTextFieldCard(
          data: dataSnapShoot.home,
          slug: dataSnapShoot.slug!,
        ),
        HeroCard(
          data: dataSnapShoot.hero,
          slug: dataSnapShoot.slug!,
        ),
        InfoAcaraCard(
          slug: dataSnapShoot.slug!,
          data: dataSnapShoot.infoAcara,
        ),
        MelFemaleCard(
          slug: dataSnapShoot.slug!,
          maleFemale: dataSnapShoot.maleFemale,
        ),
        OurStoryCard(
          slug: dataSnapShoot.slug!,
          ourStory: dataSnapShoot.ourStory,
        ),
        GaleryCard(
          slug: dataSnapShoot.slug!,
          ourGalery: dataSnapShoot.galery,
        ),
        GiftsCard(
          slug: dataSnapShoot.slug!,
          gifts: dataSnapShoot.gifts,
        ),
        CountDownCard(
          slug: dataSnapShoot.slug!,
          data: dataSnapShoot.countDown,
        )
      ],
    );
  }
}

// class FormBody extends StatelessWidget {
  
//   const FormBody({
//     super.key,
//     required this.widget,
//   });

//   final DetailUserScreen widget;

//   @override
//   Widget build(BuildContext context) {
//     return  
          
//   }
// }
