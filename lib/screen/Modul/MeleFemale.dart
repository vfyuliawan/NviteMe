// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:nvite_me/model/MaleFemaleModel.dart';
import 'package:nvite_me/utils/utils.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/ImageComponent.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/OurProjectController.dart';

class MelFemaleCard extends StatefulWidget {
  final String slug;
  final MaleFemaleModel? maleFemale;

  const MelFemaleCard({Key? key, this.maleFemale, required this.slug})
      : super(key: key);

  @override
  _MelFemaleCardState createState() => _MelFemaleCardState();
}

class _MelFemaleCardState extends State<MelFemaleCard> {
  late bool loading = false;

  @override
  Widget build(BuildContext context) {
    MaleFemaleModel data = widget.maleFemale!;

    return loading
        ? Center(
            child: LinearProgressIndicator(
              color: Constans.secondaryColor,
            ),
          )
        : Card(
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
                      padding: EdgeInsets.only(
                          right: 12, left: 12, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          right: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: Image.asset(data.icon!),
                    ),
                    title: Text(
                      data.tittle!,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: data.isOpen!
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                data.isOpen = !data.isOpen!;
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
                                data.isOpen = !data.isOpen!;
                              });
                            },
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                  ),
                  data.isOpen! ? _formBody(context, data) : Container()
                ],
              ),
            ),
          );
  }

  Widget _formBody(BuildContext context, MaleFemaleModel data) {
    return Column(
      children: [
        _formMaleFemale(context, data.male!, "Male"),
        SizedBox(
          height: 12,
        ),
        _formMaleFemale(context, data.female!, "Female"),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: SwitchComponent(
              value: data.visible!,
              onChange: (value) {
                setState(() {
                  data.visible = !data.visible!;
                });
              },
              label: 'Visible'),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TextButton(
            style:
                TextButton.styleFrom(backgroundColor: Constans.secondaryColor),
            onPressed: () async {
              setState(() {
                loading = true;
              });
              await OurProjectController()
                  .editMaleFemale(slug: widget.slug, params: widget.maleFemale)
                  .then((value) {
                if (value) {
                  Utility().themeAlert(
                    context: context,
                    title: "Update Male-Female Berhasil",
                    subtitle: "Klik Perview untuk melihat perubahan.",
                    callback: () async {
                      Navigator.pop(context);
                    },
                  );
                  setState(() {
                    loading = false;
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
                  Icon(Icons.add_to_home_screen_outlined, color: Colors.white),
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
        ),
      ],
    );
  }

  Widget _formMaleFemale(BuildContext context, Male data, String title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
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
                      color: Colors.black,
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
                      color: Colors.black,
                      size: 30,
                    ),
                  )
          ]),
          data.isOpen!
              ? Column(
                  children: [
                    FormTextField(
                      initialValue: data.ayah ?? "",
                      onChanged: (value) {
                        setState(() {
                          data.ayah = value;
                        });
                      },
                      labelText: "Nama Ayah",
                    ),
                    FormTextField(
                      initialValue: data.ibu ?? "",
                      onChanged: (value) {
                        setState(() {
                          data.ibu = value;
                        });
                      },
                      labelText: "Ibu",
                    ),
                    FormTextField(
                      initialValue: data.name ?? "",
                      onChanged: (value) {
                        setState(() {
                          data.name = value;
                        });
                      },
                      labelText: "Nama",
                    ),
                    ImageComponent(
                      label: "Gambar $title",
                      img: data.photo,
                      pickedImage: (value) {
                        setState(() {
                          data.photo = value.uri.toString();
                          data.photoFile = value;
                          data.oldPhoto = data.oldPhoto;
                        });
                      },
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
