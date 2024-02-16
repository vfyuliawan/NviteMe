// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, avoid_print, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nvite_me/model/CountDownModel.dart';
import 'package:nvite_me/widgets/DateTimeComponent.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/OurProjectController.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CountDownCard extends StatefulWidget {
  final String slug;
  final CountDownModel? data;

  const CountDownCard({Key? key, this.data, required this.slug})
      : super(key: key);

  @override
  _CountDownCardState createState() => _CountDownCardState();
}

class _CountDownCardState extends State<CountDownCard> {
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
                        setState(() {
                          widget.data!.isOpen = !widget.data!.isOpen!;
                        });
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
                            DateTimeComponent(
                              dateValue:
                                  widget.data?.date!.toDate() ?? DateTime.now(),
                              setValue: (DateTime time) {
                                print(time);
                                setState(() {
                                  widget.data!.date = Timestamp.fromDate(time);
                                });
                              },
                            ),
                            SwitchComponent(
                              onChange: (value) {
                                setState(() {
                                  widget.data!.visible = !widget.data!.visible!;
                                });
                              },
                              value: widget.data!.visible!,
                              label: 'Tampilkan CountDown',
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Constans.secondaryColor),
                              onPressed: () {
                                OurProjectController()
                                    .editCountDown(
                                  slug: widget.slug,
                                  params: CountDownModel(
                                    date: widget.data!.date!,
                                    visible: widget.data!.visible,
                                  ),
                                )
                                    .then((value) {
                                  if (value) {
                                    Alert(
                                      context: context,
                                      type: AlertType.success,
                                      title: "Update CountDown Berhasil",
                                      style: AlertStyle(
                                        titleStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        descStyle: TextStyle(fontSize: 16),
                                      ),
                                      desc:
                                          "Klik Perview untuk melihat perubahan.",
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "Oke",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          width: 120,
                                        )
                                      ],
                                    ).show();
                                  }
                                });
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
