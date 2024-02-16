// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:nvite_me/model/MaleFemaleModel.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/ImageComponent.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';

class MaleFemaleAddCard extends StatefulWidget {
  final String slug;
  final MaleFemaleModel? maleFemale;
  final Function(MaleFemaleModel) onCoverChanged;

  const MaleFemaleAddCard(
      {Key? key,
      this.maleFemale,
      required this.slug,
      required this.onCoverChanged})
      : super(key: key);

  @override
  _MaleFemaleAddCardState createState() => _MaleFemaleAddCardState();
}

class _MaleFemaleAddCardState extends State<MaleFemaleAddCard> {
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
                      child: Image.asset(widget.maleFemale!.icon!),
                    ),
                    title: Text(
                      widget.maleFemale!.tittle!,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: widget.maleFemale!.isOpen!
                        ? InkWell(
                            onTap: () {
                              if (!enableDropDown) {
                                setState(() {
                                  widget.maleFemale!.isOpen =
                                      !widget.maleFemale!.isOpen!;
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
                                widget.maleFemale!.isOpen =
                                    !widget.maleFemale!.isOpen!;
                              });
                            },
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                  ),
                  widget.maleFemale!.isOpen!
                      ? _formBody(context, widget.maleFemale!)
                      : Container()
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
                      if (!enableDropDown) {
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
                      initialValue: data.ayah ?? "",
                      onChanged: (value) {
                        setState(() {
                          data.ayah = value;
                          widget.onCoverChanged(widget.maleFemale!);
                          enableDropDown = true;
                        });
                      },
                      labelText: "Nama Ayah",
                    ),
                    FormTextField(
                      initialValue: data.ibu ?? "",
                      onChanged: (value) {
                        setState(() {
                          data.ibu = value;
                          widget.onCoverChanged(widget.maleFemale!);
                          enableDropDown = true;
                        });
                      },
                      labelText: "Ibu",
                    ),
                    FormTextField(
                      initialValue: data.name ?? "",
                      onChanged: (value) {
                        setState(() {
                          data.name = value;
                          widget.onCoverChanged(widget.maleFemale!);
                          enableDropDown = true;
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
                          widget.onCoverChanged(widget.maleFemale!);
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
