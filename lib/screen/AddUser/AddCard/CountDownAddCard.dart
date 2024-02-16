// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, avoid_print, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nvite_me/model/CountDownModel.dart';
import 'package:nvite_me/widgets/DateTimeComponent.dart';
import 'package:nvite_me/widgets/SwitchComponent.dart';

class CountDownAddCard extends StatefulWidget {
  final String slug;
  final CountDownModel? data;
  final Function(CountDownModel) onCoverChanged;

  const CountDownAddCard(
      {Key? key, this.data, required this.slug, required this.onCoverChanged})
      : super(key: key);

  @override
  _CountDownAddCardState createState() => _CountDownAddCardState();
}

class _CountDownAddCardState extends State<CountDownAddCard> {
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
                            DateTimeComponent(
                              dateValue:
                                  widget.data?.date!.toDate() ?? DateTime.now(),
                              setValue: (DateTime time) {
                                print(time);
                                setState(() {
                                  widget.data!.date = Timestamp.fromDate(time);
                                  widget.onCoverChanged(widget.data!);
                                  enableDropDown = true;
                                });
                              },
                            ),
                            SwitchComponent(
                              onChange: (value) {
                                setState(() {
                                  widget.data!.visible = !widget.data!.visible!;
                                  widget.onCoverChanged(widget.data!);
                                  enableDropDown = true;
                                });
                              },
                              value: widget.data!.visible!,
                              label: 'Tampilkan CountDown',
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
