// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nvite_me/model/InfoAcaraModel.dart';
import 'package:nvite_me/widgets/DateTimeComponent.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/ImageComponent.dart';

class InfoAcaraAddCard extends StatefulWidget {
  final String slug;
  final InfoAcaraModel? data;
  final Function(InfoAcaraModel) onCoverChanged;

  const InfoAcaraAddCard({
    Key? key,
    this.data,
    required this.slug,
    required this.onCoverChanged,
  }) : super(key: key);

  @override
  _InfoAcaraAddCardState createState() => _InfoAcaraAddCardState();
}

class _InfoAcaraAddCardState extends State<InfoAcaraAddCard> {
  late bool isEnableDropDown = false;

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
                        if (!isEnableDropDown) {
                          setState(() {
                            widget.data!.isOpen = !widget.data!.isOpen!;
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
                            context,
                            itemData.value,
                            itemData.key,
                          ),
                        );
                      }).toList()),
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
    BuildContext context,
    InfoAcaraElement data,
    int index,
  ) {
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
                        if (!isEnableDropDown) {
                          setState(() {
                            data.isOpen = !data.isOpen!;
                          });
                        }
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
                      initialValue: data.judul ?? "",
                      onChanged: (value) {
                        setState(() {
                          data.judul = value;
                          widget.onCoverChanged(widget.data!);
                          isEnableDropDown = true;
                        });
                      },
                      labelText: "Judul",
                    ),
                    FormTextField(
                      initialValue: data.place ?? "",
                      onChanged: (value) {
                        setState(() {
                          data.place = value;
                          widget.onCoverChanged(widget.data!);
                          isEnableDropDown = true;
                        });
                      },
                      labelText: "Place",
                    ),
                    FormTextField(
                      initialValue: data.map ?? "",
                      onChanged: (value) {
                        setState(() {
                          data.map = value;
                          widget.onCoverChanged(widget.data!);
                          isEnableDropDown = true;
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
                          widget.onCoverChanged(widget.data!);
                          isEnableDropDown = true;
                        });
                      },
                    ),
                    DateTimeComponent(
                      dateValue: data.date != null
                          ? data.date!.toDate()
                          : Timestamp.now().toDate(),
                      setValue: (DateTime time) {
                        print(time);
                        setState(() {
                          data.date = Timestamp.fromDate(time);
                          widget.onCoverChanged(widget.data!);
                          isEnableDropDown = true;
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
