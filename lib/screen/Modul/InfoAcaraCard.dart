// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nvite_me/controller/OurProjectController.dart';
import 'package:nvite_me/model/InfoAcaraModel.dart';
import 'package:nvite_me/widgets/DateTimeComponent.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/ImageComponent.dart';
import 'package:nvite_me/constans.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class InfoAcaraCard extends StatefulWidget {
  final String slug;
  final InfoAcaraModel? data;

  const InfoAcaraCard({Key? key, this.data, required this.slug})
      : super(key: key);

  @override
  _InfoAcaraCardState createState() => _InfoAcaraCardState();
}

class _InfoAcaraCardState extends State<InfoAcaraCard> {
  // late InfoAcaraModel dataMap;
  @override
  // void initState() {
  //   dataMap = InfoAcaraModel(
  //     infoAcara: widget.data ?? [],
  //     isOpen: false,
  //     icon: "assets/icons/info.png",
  //     tittle: "Info Acara",
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              leading: Container(
                padding:
                    EdgeInsets.only(right: 12, left: 12, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    right: BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: Image.asset(
                    widget.data!.icon ?? "assets/icons/cover-letter.png"),
              ),
              title: Text(
                widget.data!.tittle ?? "",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: widget.data!.isOpen ?? false
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          widget.data!.isOpen = !widget.data!.isOpen!;
                        });
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                        size: 30,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          widget.data!.isOpen = !widget.data!.isOpen!;
                        });
                      },
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
            ),
            widget.data!.isOpen ?? false
                ? Column(
                    children: [
                      Column(
                          children: widget.data!.infoAcara!
                              .asMap()
                              .entries
                              .map((itemData) {
                        return Container(
                          child: _formInfoWidget(
                              context, itemData.value, itemData.key),
                        );
                      }).toList()),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Constans.secondaryColor),
                          onPressed: () {
                            OurProjectController()
                                .editInfoAcara(
                              slug: widget.slug,
                              params: widget.data!.infoAcara,
                              index: 0,
                            )
                                .then((value) {
                              if (value) {
                                Alert(
                                  context: context,
                                  type: AlertType.success,
                                  title: "Update Info Acara Berhasil",
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
                                      onPressed: () => Navigator.pop(context),
                                      width: 120,
                                    )
                                  ],
                                ).show();
                              }
                            });
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
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _formInfoWidget(
      BuildContext context, InfoAcaraElement data, int index) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                index == 0 ? "Akad Nikah" : "Resepsi",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              data.isOpen!
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          data.isOpen = !data.isOpen!;
                        });
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          data.isOpen = !data.isOpen!;
                        });
                      },
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        size: 30,
                      ),
                    )
            ],
          ),
          data.isOpen!
              ? Column(
                  children: [
                    FormTextField(
                      initialValue: data.judul!,
                      onChanged: (value) {
                        setState(() {
                          data.judul = value;
                        });
                      },
                      labelText: "Judul",
                    ),
                    FormTextField(
                      initialValue: data.place!,
                      onChanged: (value) {
                        setState(() {
                          data.place = value;
                        });
                      },
                      labelText: "Place",
                      line: 3,
                    ),
                    FormTextField(
                      initialValue: data.map!,
                      onChanged: (value) {
                        setState(() {
                          data.map = value;
                        });
                      },
                      labelText: "Lokasi",
                    ),
                    ImageComponent(
                      label: "Gambar Home",
                      img: data.photo,
                      pickedImage: (value) {
                        setState(() {
                          data.photo = value.uri.toString();
                          data.oldPhoto = data.oldPhoto;
                          data.photoFile = value;
                        });
                      },
                    ),
                    DateTimeComponent(
                      dateValue: data.date!.toDate(),
                      setValue: (DateTime time) {
                        print(time);
                        setState(() {
                          data.date = Timestamp.fromDate(time);
                        });
                      },
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
