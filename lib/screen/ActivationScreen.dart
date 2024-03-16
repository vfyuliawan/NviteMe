// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, sized_box_for_whitespace, duplicate_ignore, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/OurProjectController.dart';
import 'package:nvite_me/model/UserIdModel.dart';
import 'package:nvite_me/service/WhatsAppService.dart';
import 'package:nvite_me/utils/utils.dart';

class ActivationScreen extends StatefulWidget {
  final UserIdModel detailUser;
  final int status;
  const ActivationScreen(
      {Key? key, required this.detailUser, required this.status})
      : super(key: key);

  @override
  _ActivationScreenState createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  bool loading = false;

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
            return loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
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
                                          widget.detailUser.themeName!
                                                  .isNotEmpty
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          widget.status == 4 ||
                                                  widget.status == 5
                                              ? _statusByUser()
                                              : _statusByAdmin()
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
        },
      ),
    );
  }

  Widget _statusByAdmin() {
    return widget.status == 2
        ? Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/icons/waiting.png',
                width: 250,
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "${widget.detailUser.slug} is Waiting for your approval, approve the Project immidiately",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: 280,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Constans.secondaryColor),
                  onPressed: () async {
                    await OurProjectController()
                        .editActivation(
                            slug: widget.detailUser.slug!, status: 3)
                        .then((value) {
                      if (value) {
                        Utility().themeAlert(
                            context: context,
                            title: "Berhasil di approve",
                            subtitle: "Project sudah berhasil di approve",
                            callback: () {
                              Navigator.pop(context);
                              Navigator.pop(
                                context,
                              );
                            });
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.check, color: Colors.white),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Approve',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/icons/empty.png',
                width: 250,
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "User has not yet sending requested approval",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: 280,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Constans.secondaryColor),
                  onPressed: () async {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back_ios, color: Colors.white),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Back',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Widget _statusByUser() {
    return widget.status == 4
        ? Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/icons/lifestyle.png',
                width: 250,
                height: 200,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Hore.... Your web application is waiting for verification",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: 280,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Constans.secondaryColor),
                  onPressed: () async {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Back',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/icons/stop.png',
                width: 250,
                height: 200,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Your Web Application has not been Actived, click button below for Activation",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: 280,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Constans.secondaryColor),
                  onPressed: () async {
                    Utility().themeAlert(
                      context: context,
                      title: "Akan Dialihkan ke whatsapp",
                      subtitle:
                          "Request Aktifasi akan di kirim melalui WhatsApp",
                      callback: () async {
                        WhatsAppService()
                            .activationByWA(widget.detailUser.slug!)
                            .then((value) async {
                          if (value) {
                            Utility().themeAlert(
                              context: context,
                              title: "Pastikan Pesan Sudah Terkirim",
                              subtitle: "Menunggu Aktifasi Web Aplication",
                              callback: () async {
                                await OurProjectController()
                                    .editActivation(
                                        slug: widget.detailUser.slug!,
                                        status: 2)
                                    .then((value) {
                                  if (value) {
                                    Navigator.pop(context);
                                    Navigator.pop(
                                      context,
                                    );
                                    Navigator.pop(
                                      context,
                                    );
                                  }
                                });
                              },
                            );
                          }
                        });
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.local_attraction_rounded,
                            color: Colors.white),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Activation',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
