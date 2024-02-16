// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_element

import 'package:flutter/material.dart';
import 'package:nvite_me/controller/OurProjectController.dart';
import 'package:nvite_me/model/GaleryModel.dart';
import 'package:nvite_me/widgets/MultipleImageWIdget.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';
import 'package:nvite_me/constans.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class GaleryCard extends StatefulWidget {
  final String slug;
  final GaleryModel? ourGalery;

  const GaleryCard({Key? key, this.ourGalery, required this.slug})
      : super(key: key);

  @override
  _GaleryCardState createState() => _GaleryCardState();
}

class _GaleryCardState extends State<GaleryCard> {
  late bool loading = false;

  @override
  Widget build(BuildContext context) {
    GaleryModel data = widget.ourGalery!;

    return loading
        ? Center(
            child: CircularProgressIndicator(),
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
                  data.isOpen!
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: _formBody(context, data))
                      : Container()
                ],
              ),
            ),
          );
  }

  Widget _formBody(BuildContext context, GaleryModel data) {
    return Column(
      children: [
        MultipleImageComponent(
          slug: widget.slug,
          label: "Galery",
          images: data.image,
          pickedImage: (value) {
            OurProjectController()
                .uploadImageGalery(value, widget.slug)
                .then((value) {
              if (value) {
                Alert(
                  context: context,
                  type: AlertType.success,
                  title: "Upload Image Berhasil",
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
            });
          },
          imagesFile: data.imageFile,
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
            onPressed: () {},
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
}
