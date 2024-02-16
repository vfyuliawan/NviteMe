// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_element

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nvite_me/model/GaleryModel.dart';
import 'package:nvite_me/widgets/MultipleImageAdd.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';

class GaleryAddCard extends StatefulWidget {
  final String slug;
  final GaleryModel? ourGalery;
  final Function(GaleryModel) onCoverChanged;

  const GaleryAddCard({
    Key? key,
    this.ourGalery,
    required this.slug,
    required this.onCoverChanged,
  }) : super(key: key);

  @override
  _GaleryAddCardState createState() => _GaleryAddCardState();
}

class _GaleryAddCardState extends State<GaleryAddCard> {
  late bool enableDropDown = false;

  late bool loading = false;

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
                      child: Image.asset(widget.ourGalery!.icon ?? ""),
                    ),
                    title: Text(
                      widget.ourGalery!.tittle!,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: widget.ourGalery!.isOpen!
                        ? InkWell(
                            onTap: () {
                              if (!enableDropDown) {
                                setState(() {
                                  widget.ourGalery!.isOpen =
                                      !widget.ourGalery!.isOpen!;
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
                                widget.ourGalery!.isOpen =
                                    !widget.ourGalery!.isOpen!;
                              });
                            },
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                  ),
                  widget.ourGalery!.isOpen!
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: _formBody(context, widget.ourGalery!))
                      : Container()
                ],
              ),
            ),
          );
  }

  Widget _formBody(BuildContext context, GaleryModel data) {
    return Column(
      children: [
        MultipleImageAdd(
          slug: widget.slug,
          label: "Galery",
          images: data.image,
          imagesFile: data.imageFile ?? [],
          pickedImage: (List<File>? value) {
            setState(() {
              widget.ourGalery!.image =
                  value!.map((e) => e.uri.toString()).toList();
              widget.ourGalery!.imageFile = value;
              widget.onCoverChanged(widget.ourGalery!);
              enableDropDown = true;
            });
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: SwitchComponent(
              value: data.visible!,
              onChange: (value) {
                setState(() {
                  data.visible = !data.visible!;
                  widget.onCoverChanged(widget.ourGalery!);
                  enableDropDown = true;
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
}
