// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nvite_me/model/OurStoryModel.dart';
import 'package:nvite_me/widgets/DateTimeComponent.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/ImageComponent.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';

class OurStoryAdd extends StatefulWidget {
  final String slug;
  final OurStoryModel? ourStory;
  final Function(OurStoryModel) onCoverChanged;

  const OurStoryAdd(
      {Key? key,
      this.ourStory,
      required this.slug,
      required this.onCoverChanged})
      : super(key: key);

  @override
  _OurStoryAddState createState() => _OurStoryAddState();
}

class _OurStoryAddState extends State<OurStoryAdd> {
  late bool loading = false;
  late bool enableDropDown = false;

  @override
  Widget build(BuildContext context) {
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
                      child: Image.asset(widget.ourStory!.icon!),
                    ),
                    title: Text(
                      widget.ourStory!.tittle!,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: widget.ourStory!.isOpen!
                        ? InkWell(
                            onTap: () {
                              if (!enableDropDown) {
                                setState(() {
                                  widget.ourStory!.isOpen =
                                      !widget.ourStory!.isOpen!;
                                });
                              }
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
                                widget.ourStory!.isOpen =
                                    !widget.ourStory!.isOpen!;
                              });
                            },
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                  ),
                  widget.ourStory!.isOpen!
                      ? _formBody(context, widget.ourStory!)
                      : Container()
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
                  widget.onCoverChanged(widget.ourStory!);
                });
              },
              label: 'Visible'),
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
                      if (enableDropDown) {
                        setState(() {
                          data.isOpen = !data.isOpen!;
                        });
                      }
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
                      initialValue: data.tittle ?? "",
                      onChanged: (value) {
                        setState(() {
                          data.tittle = value;
                          widget.onCoverChanged(widget.ourStory!);
                          enableDropDown = true;
                        });
                      },
                      labelText: "Title",
                    ),
                    FormTextField(
                      initialValue: data.story ?? "",
                      onChanged: (value) {
                        setState(() {
                          data.story = value;
                          widget.onCoverChanged(widget.ourStory!);
                          enableDropDown = true;
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
                          widget.onCoverChanged(widget.ourStory!);
                          enableDropDown = true;
                        });
                      },
                    ),
                    DateTimeComponent(
                      dateValue: data.date!.toDate(),
                      setValue: (DateTime time) {
                        print(time);
                        setState(() {
                          data.date = Timestamp.fromDate(time);
                          widget.onCoverChanged(widget.ourStory!);
                          enableDropDown = true;
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
