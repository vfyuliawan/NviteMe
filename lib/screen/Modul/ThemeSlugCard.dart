// ignore_for_file: public_member_api_docs, sort_constructors_first, sort_child_properties_last, prefer_interpolation_to_compose_strings
// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nvite_me/utils/utils.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/OurProjectController.dart';
import 'package:nvite_me/model/GuestModel.dart';
import 'package:nvite_me/screen/GuestScreen.dart';
import 'package:nvite_me/widgets/DropDownWidget.dart';
import 'package:nvite_me/widgets/FormTextField.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';

// ignore: must_be_immutable
class ThemeSlugCard extends StatefulWidget {
  late String? slug;
  late String? thema;
  late String? song;
  late bool? guestBarcode;
  late String embeded;
  late GuestModel guest;

  ThemeSlugCard({
    Key? key,
    this.slug,
    this.thema,
    this.song,
    this.guestBarcode,
    required this.embeded,
    required this.guest,
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
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "For chnage slug URL please contact administrator",
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                      ),
                      SizedBox(height: 10),
                      SwitchComponent(
                        onChange: (value) {
                          setState(() {
                            widget.guestBarcode = !widget.guestBarcode!;
                          });
                        },
                        value: widget.guestBarcode!,
                        label: 'Aktifkan Checkin Tamu',
                      ),
                      !widget.guestBarcode!
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GuestScreen(
                                      guests: widget.guest,
                                      slug: widget.slug!,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_sharp,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Kelola Buku Tamu Digital",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w100,
                                          decorationColor: Colors.blueAccent),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 10,
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
                          suffix:
                              widget.guestBarcode! ? null : Icon(Icons.copy),
                          enable: widget.guestBarcode! ? false : false,
                          initialValue: Constans.baseUrlDeploy +
                              widget.slug! +
                              '&to=Your_Guest',
                          onChanged: (value) {},
                          line: 2,
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
                      FormTextField(
                        initialValue: widget.embeded,
                        enable: true,
                        line: 7,
                        onChanged: (value) {
                          setState(() {
                            widget.embeded = value;
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
                          height: 20,
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
                        icon: Icons.tablet_android,
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
                              embeded: widget.embeded,
                              themeName: widget.thema,
                            )
                                .then((value) {
                              if (value) {
                                Utility().themeAlert(
                                  context: context,
                                  title: "Update Tema Berhasil",
                                  subtitle:
                                      "Klik Perview untuk melihat perubahan.",
                                  callback: () async {
                                    Navigator.pop(context);
                                  },
                                );
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
