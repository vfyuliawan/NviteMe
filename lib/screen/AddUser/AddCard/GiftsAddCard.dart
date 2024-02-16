// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_element

import 'package:flutter/material.dart';
import 'package:nvite_me/model/GiftsModel.dart';
import 'package:nvite_me/widgets/DropDownWidget.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';

class GiftsAddCard extends StatefulWidget {
  final String slug;
  final GiftstModel? gifts;
  final Function(GiftstModel) onCoverChanged;

  const GiftsAddCard(
      {Key? key, this.gifts, required this.slug, required this.onCoverChanged})
      : super(key: key);

  @override
  _GiftsAddCardState createState() => _GiftsAddCardState();
}

class _GiftsAddCardState extends State<GiftsAddCard> {
  late bool loading = false;
  late bool enableDropDown = false;

  @override
  Widget build(BuildContext context) {
    List<String> listOfCard = [
      "ImageBca",
      "ImageBri",
      "ImageOvo",
    ];

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
                      child: Image.asset(widget.gifts!.icon),
                    ),
                    title: Text(
                      widget.gifts!.tittle,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: widget.gifts!.isOpen
                        ? InkWell(
                            onTap: () {
                              if (!enableDropDown) {
                                setState(() {
                                  widget.gifts!.isOpen = !widget.gifts!.isOpen;
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
                                widget.gifts!.isOpen = !widget.gifts!.isOpen;
                              });
                            },
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                  ),
                  widget.gifts!.isOpen
                      ? _formBody(context, widget.gifts!, listOfCard)
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
                      if (!enableDropDown) {
                        setState(() {
                          data.isOpen = !data.isOpen!;
                        });
                      }
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
                      initial: data.image ?? "ImageBca",
                      setValue: (String value) {
                        setState(() {
                          data.image = value;
                          widget.onCoverChanged(widget.gifts!);
                          enableDropDown = true;
                        });
                      },
                      icon: Icons.card_membership,
                    ),
                    FormTextField(
                      initialValue: data.name ?? "",
                      onChanged: (value) {
                        setState(() {
                          data.name = value;
                          widget.onCoverChanged(widget.gifts!);
                          enableDropDown = true;
                        });
                      },
                      labelText: "Nama",
                    ),
                    FormTextField(
                      initialValue: data.noRek ?? "",
                      onChanged: (value) {
                        setState(() {
                          data.noRek = value;
                          widget.onCoverChanged(widget.gifts!);
                          enableDropDown = true;
                        });
                      },
                      labelText: "No Rekening",
                    ),
                    SwitchComponent(
                        value: data.visible!,
                        onChange: (value) {
                          setState(() {
                            data.visible = !data.visible!;
                            widget.onCoverChanged(widget.gifts!);
                            enableDropDown = true;
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
