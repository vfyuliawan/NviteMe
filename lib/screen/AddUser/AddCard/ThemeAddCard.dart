// ignore_for_file: public_member_api_docs, sort_constructors_first, sort_child_properties_last, prefer_interpolation_to_compose_strings
// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:nvite_me/constans.dart';
import 'package:nvite_me/widgets/DropDownWidget.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';

// ignore: must_be_immutable
class ThemeAddCard extends StatefulWidget {
  late String? slug;
  late String? thema;
  late String? song;
  late bool? guestBarcode;
  late String embeded;
  final Function(String? slug, String? themeSong, String? themeName,
      bool? guestBarcode, String embeded) onChange;

  ThemeAddCard({
    Key? key,
    this.slug,
    this.thema,
    this.song,
    this.guestBarcode,
    required this.embeded,
    required this.onChange,
  }) : super(key: key);

  @override
  _ThemeAddCardState createState() => _ThemeAddCardState();
}

class _ThemeAddCardState extends State<ThemeAddCard> {
  late bool isOpen = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => setState(() {
                isOpen = !isOpen;
              }),
              child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Theme",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 33,
                      )
                    ]),
              ),
            ),
            isOpen
                ? Column(
                    children: [
                      SwitchComponent(
                          value: widget.guestBarcode!,
                          onChange: (value) {
                            setState(() {
                              widget.guestBarcode = !widget.guestBarcode!;
                              widget.onChange(
                                widget.slug,
                                widget.song,
                                widget.thema,
                                widget.guestBarcode,
                                widget.embeded,
                              );
                            });
                          },
                          label: "Manage Guest"),
                      !widget.guestBarcode!
                          ? Container(
                              child: FormTextField(
                                enable: false,
                                line: 2,
                                fillColor: Colors.black12,
                                initialValue: Constans.baseUrlDeploy +
                                    widget.slug! +
                                    '&to=Your_Guest',
                                onChanged: (value) {},
                                labelText: "Your Link",
                              ),
                            )
                          : Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Kelola Tamu Undangan",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blueAccent),
                              )),
                      !widget.guestBarcode!
                          ? Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Replace your_guest with your guest name",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ))
                          : Container(),
                      FormTextField(
                        initialValue: widget.slug!,
                        onChanged: (value) {
                          setState(() {
                            widget.slug = value;
                            widget.onChange(
                              widget.slug,
                              widget.song,
                              widget.thema,
                              widget.guestBarcode,
                              widget.embeded,
                            );
                          });
                        },
                        labelText: "Slug",
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "it more prefere for not use (Space) and make sure your Slug URL is correct, it cannot change after process",
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                      ),
                      FormTextField(
                        initialValue: widget.embeded,
                        line: 5,
                        onChanged: (value) {
                          setState(() {
                            widget.embeded = value;
                            widget.onChange(
                              widget.slug,
                              widget.song,
                              widget.thema,
                              widget.guestBarcode,
                              widget.embeded,
                            );
                          });
                        },
                        labelText: "Embeded",
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Copy only Embeded Link From The Google Map",
                          style: TextStyle(fontSize: 12, color: Colors.green),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Select Theme",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Image.asset(
                            "assets/images/theme/${widget.thema}.png"),
                      ),
                      SizedBox(height: 10),
                      DropdownWidget(
                        icon: Icons.area_chart,
                        list: Constans.listTheme,
                        initial: widget.thema,
                        setValue: (String value) {
                          setState(() {
                            widget.thema = value;
                            widget.onChange(
                              widget.slug,
                              widget.song,
                              widget.thema,
                              widget.guestBarcode,
                              widget.embeded,
                            );
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      DropdownWidget(
                        icon: Icons.music_note,
                        list: Constans.listThemeSong,
                        initial: widget.song,
                        setValue: (String value) {
                          setState(() {
                            widget.song = value;
                            widget.onChange(
                              widget.slug,
                              widget.song,
                              widget.thema,
                              widget.guestBarcode,
                              widget.embeded,
                            );
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 15),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
