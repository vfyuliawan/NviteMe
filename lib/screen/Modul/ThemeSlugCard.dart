// ignore_for_file: public_member_api_docs, sort_constructors_first, sort_child_properties_last, prefer_interpolation_to_compose_strings
// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/OurProjectController.dart';
import 'package:nvite_me/widgets/DropDownWidget.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';

// ignore: must_be_immutable
class ThemeSlugCard extends StatefulWidget {
  late String? slug;
  late String? thema;
  late String? song;
  late bool? guestBarcode;

  ThemeSlugCard({
    Key? key,
    this.slug,
    this.thema,
    this.song,
    this.guestBarcode,
  }) : super(key: key);

  @override
  _ThemeSlugCardState createState() => _ThemeSlugCardState();
}

class _ThemeSlugCardState extends State<ThemeSlugCard> {
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
                      FormTextField(
                        initialValue: widget.slug!,
                        fillColor: Colors.black12,
                        enable: false,
                        onChanged: (value) {
                          setState(() {
                            widget.slug = value;
                          });
                        },
                        labelText: "Slug",
                      ),
                      Text(
                        "For chnage slug URL please contact administrator",
                        style: TextStyle(fontSize: 12, color: Colors.red),
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
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      SwitchComponent(
                        onChange: (value) {
                          setState(() {
                            widget.guestBarcode = !widget.guestBarcode!;
                          });
                        },
                        value: widget.guestBarcode!,
                        label: 'Tampilkan Slug',
                      ),
                      !widget.guestBarcode!
                          ? Container()
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
                              ),
                            ),
                      GestureDetector(
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
                          sufix: widget.guestBarcode! ? false : true,
                          enable: widget.guestBarcode! ? false : false,
                          initialValue: Constans.baseUrlDeploy +
                              widget.slug! +
                              '&to=Your_Guest',
                          onChanged: (value) {},
                          labelText: "Your Link",
                        ),
                      ),
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
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Constans.secondaryColor),
                          onPressed: () {
                            OurProjectController()
                                .editTheme(
                              song: widget.song!,
                              slug: widget.slug!,
                              guestBarcode: widget.guestBarcode!,
                              themeName: widget.thema,
                            )
                                .then((value) {
                              if (value) {
                                Alert(
                                  context: context,
                                  type: AlertType.success,
                                  title: "Update Tema Berhasil",
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
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
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
                            ;
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.add_to_home_screen_outlined,
                                    color: Colors.white),
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
