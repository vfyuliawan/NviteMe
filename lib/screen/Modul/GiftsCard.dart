// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_element

import 'package:flutter/material.dart';
import 'package:nvite_me/controller/OurProjectController.dart';
import 'package:nvite_me/model/GiftsModel.dart';
import 'package:nvite_me/widgets/DropDownWidget.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';
import 'package:nvite_me/constans.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class GiftsCard extends StatefulWidget {
  final String slug;
  final GiftstModel? gifts;

  const GiftsCard({Key? key, this.gifts, required this.slug}) : super(key: key);

  @override
  _GiftsCardState createState() => _GiftsCardState();
}

class _GiftsCardState extends State<GiftsCard> {
  late bool loading = false;

  @override
  Widget build(BuildContext context) {
    GiftstModel data = widget.gifts!;

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
                      child: Image.asset(data.icon),
                    ),
                    title: Text(
                      data.tittle,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: data.isOpen
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                data.isOpen = !data.isOpen;
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
                                data.isOpen = !data.isOpen;
                              });
                            },
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                  ),
                  data.isOpen
                      ? _formBody(context, data, Constans.listDebitCard)
                      : Container()
                ],
              ),
            ),
          );
  }

  Widget _formBody(
      BuildContext context, GiftstModel data, List<String> listOfCard) {
    return Column(
      children: [
        _formOurStory(context, data.first!, "First", listOfCard),
        SizedBox(
          height: 10,
        ),
        _formOurStory(context, data.second!, "Second", listOfCard),
        SizedBox(
          height: 10,
        ),
        _formOurStory(context, data.third!, "Third", listOfCard),
        SizedBox(
          height: 10,
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
            onPressed: () {
              OurProjectController()
                  .editGifts(slug: widget.slug, params: widget.gifts)
                  .then((value) {
                if (value) {
                  Alert(
                    context: context,
                    type: AlertType.success,
                    title: "Update Story Berhasil",
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

  Widget _formOurStory(BuildContext context, GiftsKeyValue data, String title,
      List<String> listOfCard) {
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
                  fontSize: 15),
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
                    DropdownWidget(
                      list: listOfCard,
                      initial: data.image,
                      percentage: 0.84,
                      setValue: (String value) {
                        setState(() {});
                      },
                      icon: Icons.card_giftcard,
                    ),
                    FormTextField(
                      initialValue: data.name!,
                      onChanged: (value) {
                        setState(() {
                          data.name = value;
                        });
                      },
                      labelText: "Nama",
                    ),
                    FormTextField(
                      initialValue: data.noRek!,
                      onChanged: (value) {
                        setState(() {
                          data.noRek = value;
                        });
                      },
                      labelText: "No Rekening",
                    ),
                    SwitchComponent(
                        value: data.visible!,
                        onChange: (value) {
                          setState(() {
                            data.visible = !data.visible!;
                          });
                        },
                        label: 'Tampilkan $title'),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
