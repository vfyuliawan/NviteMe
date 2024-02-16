// ignore_for_file: public_member_api_docs, sort_constructors_first, sort_child_properties_last, unused_element, unnecessary_brace_in_string_interps, avoid_print
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nvite_me/model/HeroModel.dart';
import 'package:nvite_me/widgets/DateTimeComponent.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/ImageComponent.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';

class HeroAddCard extends StatefulWidget {
  final String slug;
  final HeroModel? data;
  final Function(HeroModel) onCoverChanged;

  const HeroAddCard({
    Key? key,
    required this.data,
    required this.slug,
    required this.onCoverChanged,
  }) : super(key: key);

  @override
  _HeroAddCardState createState() => _HeroAddCardState();
}

class _HeroAddCardState extends State<HeroAddCard> {
  late bool isLoading = false;
  late bool enableDropDown = false;

  void _refresh() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                      child: Image.asset(
                          widget.data?.icon ?? "assets/icons/Hero.png"),
                    ),
                    title: Text(
                      widget.data?.tittle ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: widget.data?.isOpen ?? false
                        ? InkWell(
                            onTap: () {
                              if (!enableDropDown) {
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
                  widget.data?.isOpen ?? false
                      ? Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  FormTextField(
                                    initialValue: widget.data!.heroTittle ?? "",
                                    onChanged: (value) {
                                      setState(() {
                                        widget.data!.heroTittle = value;
                                        widget.onCoverChanged(widget.data!);
                                        enableDropDown = true;
                                      });
                                    },
                                    labelText: "Hero Tittle",
                                  ),
                                  ImageComponent(
                                    label: "Gambar Hero",
                                    img: widget.data!.heroImg,
                                    pickedImage: (value) {
                                      setState(() {
                                        widget.data!.heroImg =
                                            value.uri.toString();
                                        widget.data!.heroImgFile = value;
                                        widget.onCoverChanged(widget.data!);
                                        enableDropDown = true;
                                      });
                                    },
                                  ),
                                  SwitchComponent(
                                      value: widget.data!.visible!,
                                      onChange: (value) {
                                        setState(() {
                                          widget.data!.visible = value;
                                          widget.onCoverChanged(widget.data!);
                                          enableDropDown = true;
                                        });
                                      },
                                      label: "Tampilkan Hero"),
                                  DateTimeComponent(
                                    dateValue: widget.data!.heroDate!.toDate(),
                                    setValue: (value) {
                                      setState(() {
                                        widget.data!.heroDate =
                                            Timestamp.fromDate(value);
                                        widget.onCoverChanged(widget.data!);
                                        enableDropDown = true;
                                      });
                                    },
                                  ),
                                ],
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
}
