// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/ImageComponent.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';
import 'package:nvite_me/model/HomeModel.dart';

class HomeAddCard extends StatefulWidget {
  final String slug;
  final HomeModel? data;
  final Function(HomeModel) onCoverChanged;

  const HomeAddCard(
      {Key? key, this.data, required this.slug, required this.onCoverChanged})
      : super(key: key);

  @override
  _HomeAddCardState createState() => _HomeAddCardState();
}

class _HomeAddCardState extends State<HomeAddCard> {
  late bool enableDropDown = false;

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
                    widget.data?.icon ?? "assets/icons/cover-letter.png"),
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
                              initialValue: widget.data!.homeTittle ?? "",
                              onChanged: (value) {
                                setState(() {
                                  widget.data!.homeTittle = value;
                                  widget.onCoverChanged(widget.data!);
                                  enableDropDown = true;
                                });
                              },
                              labelText: "Home Title",
                            ),
                            FormTextField(
                              initialValue: widget.data!.homeQuotes ?? "",
                              line: 4,
                              onChanged: (value) {
                                setState(() {
                                  widget.data!.homeQuotes = value;
                                  widget.onCoverChanged(widget.data!);
                                  enableDropDown = true;
                                });
                              },
                              labelText: "Home Quotes",
                            ),
                            ImageComponent(
                              label: "Gambar Home",
                              img: widget.data!.homeImg,
                              pickedImage: (value) {
                                setState(() {
                                  widget.data!.homeImg = value.uri.toString();
                                  widget.data!.homeImgFile = value;
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
                                label: "Tampilkan Home"),
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
