// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nvite_me/constans.dart';

class OurProject extends StatefulWidget {
  const OurProject({Key? key}) : super(key: key);

  @override
  State<OurProject> createState() => _OurProjectState();
}

class _OurProjectState extends State<OurProject> {
  List<Map<String, dynamic>> test = [
    {
      "name": "Cover Depan",
      "icon": Image.asset("assets/icons/cover-letter.png", fit: BoxFit.cover),
      "isOpen": true,
      "form": [
        {"label": "Title", "value": "Judul"},
        {"label": "Image", "value": "assets/images/onboarding_sec.png"},
        {"label": "Date", "value": DateTime.now()},
        {"label": "IsVisible", "value": true},
      ]
    },
    {
      "name": "Home",
      "icon": Image.asset("assets/icons/homework.png"),
      "isOpen": true,
      "form": [
        {"label": "Title", "value": "Tesxt"},
        {"label": "Quotes", "value": "Tesxt"},
        {"label": "Image", "value": ""},
        {"label": "Date", "value": DateTime.now()},
        {"label": "IsVisible", "value": true},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            var item = test[index];
            return Card(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
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
                          color: Colors.white,
                          border: Border(
                            right: BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        child: item["icon"],
                      ),
                      title: Text(
                        item["name"],
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: item["isOpen"]
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  item["isOpen"] = !item["isOpen"];
                                });
                              },
                              child: Icon(
                                Icons.keyboard_arrow_left,
                                color: Colors.black,
                                size: 30,
                              ),
                            )
                          : InkWell(
                              onTap: () => setState(() {
                                item["isOpen"] = !item["isOpen"];
                              }),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                                color: Colors.black,
                              ),
                            ),
                    ),
                    !item["isOpen"]
                        ? Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: (item["form"] as List<dynamic>).map(
                                    (itemForm) {
                                      return formWidget(itemForm);
                                    },
                                  ).toList(),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Constans.secondaryColor),
                                onPressed: () {},
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
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
          },
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: test.length,
        ),
      ),
    );
  }

  Widget formWidget(itemForm) {
    File? pickedImage;

    Future<void> onPickImage() async {
      try {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            pickedImage = File(pickedFile.path);
          });
        }
      } catch (e) {
        print(e);
      }
    }

    TextEditingController dateController =
        TextEditingController(text: itemForm["value"].toString().split(" ")[0]);
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: itemForm["value"],
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != itemForm["value"]) {
        setState(() {
          itemForm['value'] = picked;
          dateController.text = "${itemForm["value"].toLocal()}".split(' ')[0];
        });
      }
    }

    return Container(
      margin: EdgeInsets.only(top: 3, bottom: 3),
      child: itemForm["label"] == "IsVisible"
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Visible"),
                Switch(
                  value: (itemForm["value"] as bool),
                  activeColor: Constans.secondaryColor,
                  onChanged: (value) {
                    setState(() {
                      itemForm["value"] = value;
                    });
                  },
                ),
              ],
            )
          : itemForm["label"] == "Date"
              ? TextField(
                  controller: dateController,
                  onTap: () => selectDate(context),
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    hintText: "${itemForm["value"].toLocal()}".split(' ')[0],
                    suffixIcon: Icon(Icons.calendar_month_sharp),
                  ),
                )
              : itemForm["label"] == "Image"
                  ? Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Image"),
                            itemForm["value"] != ""
                                ? Image.asset(
                                    "${itemForm["value"]}",
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : pickedImage != null
                                    ? Image.file(
                                        pickedImage!,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      )
                                    : InkWell(
                                        onTap: () {
                                          onPickImage();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top: 10),
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Icon(
                                            Icons.add_a_photo_rounded,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                          ],
                        ),
                      ],
                    )
                  : TextField(
                      controller: TextEditingController(
                        text: itemForm["value"].toString(),
                      ),
                      onChanged: (value) {
                        itemForm["value"] = value;
                      },
                      decoration: InputDecoration(
                        labelText: itemForm["label"],
                      ),
                    ),
    );
  }
}
