// ignore_for_file: public_member_api_docs, sort_constructors_first, sort_child_properties_last, prefer_interpolation_to_compose_strings
// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:nvite_me/constans.dart';
import 'package:nvite_me/utils/utils.dart';
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
                        label: "Aktifkan Checkin Tamu",
                      ),
                      !widget.guestBarcode!
                          ? GestureDetector(
                              onTap: () {
                                if (!widget.guestBarcode!) {
                                  Clipboard.setData(ClipboardData(
                                      text: Constans.baseUrlDeploy +
                                          widget.slug! +
                                          '&to=Your_Guest'));
                                }
                              },
                              child: FormTextField(
                                fillColor: widget.guestBarcode!
                                    ? Colors.black12
                                    : Colors.black12,
                                suffix: widget.guestBarcode!
                                    ? null
                                    : Icon(Icons.copy),
                                enable: widget.guestBarcode! ? false : false,
                                initialValue: Constans.baseUrlDeploy +
                                    widget.slug! +
                                    '&to=Your_Guest',
                                onChanged: (value) {},
                                line: 2,
                                labelText: "Your Link",
                              ),
                            )
                          : Container(),
                      !widget.guestBarcode!
                          ? Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Replace your_guest with your guest name",
                                style: TextStyle(
                                  color: !widget.guestBarcode!
                                      ? Colors.red
                                      : Colors.grey,
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
                      SizedBox(
                        height: 4,
                      ),
                      GestureDetector(
                        onTap: () async => Utility()
                            .openWebBrowser("https://www.embed-map.com"),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: Colors.blue,
                              ),
                              Text(
                                "Click here to get Embeded map",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.blue),
                              ),
                            ],
                          ),
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
