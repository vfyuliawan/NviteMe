// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nvite_me/controller/OurProjectController.dart';
import 'package:nvite_me/model/OurStoryModel.dart';
import 'package:nvite_me/widgets/DateTimeComponent.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/ImageComponent.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';
import 'package:nvite_me/constans.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OurStoryCard extends StatefulWidget {
  final String slug;
  final OurStoryModel? ourStory;

  const OurStoryCard({Key? key, this.ourStory, required this.slug})
      : super(key: key);

  @override
  _OurStoryCardState createState() => _OurStoryCardState();
}

class _OurStoryCardState extends State<OurStoryCard> {
  late bool loading = false;

  @override
  Widget build(BuildContext context) {
    OurStoryModel data = widget.ourStory!;

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
                  data.isOpen! ? _formBody(context, data) : Container()
                ],
              ),
            ),
          );
  }

  Widget _formBody(BuildContext context, OurStoryModel data) {
    return Column(
      children: [
        _formOurStory(context, data.first!, "First"),
        SizedBox(
          height: 10,
        ),
        _formOurStory(context, data.second!, "Second"),
        SizedBox(
          height: 10,
        ),
        _formOurStory(context, data.third!, "Third"),
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
                  .editOurStory(slug: widget.slug, params: widget.ourStory)
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

  Widget _formOurStory(
      BuildContext context, KeyValueOuStory data, String title) {
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
                    FormTextField(
                      initialValue: data.tittle!,
                      onChanged: (value) {
                        setState(() {
                          data.tittle = value;
                        });
                      },
                      labelText: "Title",
                    ),
                    FormTextField(
                      initialValue: data.story!,
                      onChanged: (value) {
                        setState(() {
                          data.story = value;
                        });
                      },
                      labelText: "Story",
                    ),
                    ImageComponent(
                      label: "Gambar $title",
                      img: data.photo,
                      pickedImage: (value) {
                        setState(() {
                          data.photo = value.uri.toString();
                          data.photoFile = value;
                          data.photoOld = data.photoOld;
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
              : Container()
        ],
      ),
    );
  }
}
