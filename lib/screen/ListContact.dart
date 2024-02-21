// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_new
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/OurProjectController.dart';
import 'package:nvite_me/model/GuestModel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListContact extends StatefulWidget {
  final String slug;
  final GuestModel guest;
  const ListContact({Key? key, required this.slug, required this.guest})
      : super(key: key);

  @override
  _ListContactState createState() => _ListContactState();
}

class _ListContactState extends State<ListContact> {
  late bool loading = false;
  late bool enableApply = true;
  late bool isOpenBalance = true;

  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  List<Contact>? _contacts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: !loading
          ? Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor:
                        !enableApply ? Colors.grey : Constans.secondaryColor),
                onPressed: () async {
                  await OurProjectController()
                      .addGuest(
                    slug: widget.slug,
                    params: _contacts,
                    guest: widget.guest,
                  )
                      .then((value) {
                    if (value) {
                      Alert(
                        context: context,
                        type: AlertType.success,
                        title: "Update Guest Berhasil",
                        style: AlertStyle(
                          titleStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          descStyle: TextStyle(fontSize: 16),
                        ),
                        desc: "Kirim undangan ke tamu anda via whatsapp.",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Oke",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            width: 120,
                          )
                        ],
                      ).show();
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.contact_emergency, color: Colors.white),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Add To Guest  ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      body: loading
          ? Container(
              decoration: BoxDecoration(
                color: Constans.secondaryColor,
              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: Constans.fourthColor,
                ),
              ),
            )
          : Column(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            color: Constans.secondaryColor,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            margin: const EdgeInsets.only(top: 35),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Guest Book",
                                  style: TextStyle(
                                    fontFamily: 'Pacifico',
                                    fontWeight: FontWeight.w200,
                                    fontSize: 25,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 150,
                          margin: const EdgeInsets.only(top: 80),
                          decoration: BoxDecoration(
                              color: Constans.thirdColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              )),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Add Contact",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'Pacifico',
                                            color: Constans.textColor,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (Platform.isIOS) {
                                            final contacts =
                                                await _contactPicker
                                                    .selectContacts();
                                            setState(() {
                                              _contacts!.addAll(
                                                contacts!.map((entry) {
                                                  return Contact(
                                                    fullName: entry.fullName,
                                                    phoneNumbers:
                                                        entry.phoneNumbers,
                                                  );
                                                }),
                                              );
                                            });
                                          } else {
                                            final contacts =
                                                await _contactPicker
                                                    .selectContact();
                                            if (contacts != null) {
                                              setState(() {
                                                _contacts!.add(contacts);
                                              });
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          child: Icon(
                                            Icons.add,
                                            size: 28,
                                            color: Constans.textColor,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                      color: Constans.fourthColor,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                      )),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(left: 8),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "List Contact",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              )),
                                          _listContact(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 90, right: 20),
                          alignment: Alignment.centerRight,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _listContact() {
    return _contacts != null && _contacts!.isNotEmpty
        ? Column(
            children: _contacts!
                .map(
                  (item) => Card(
                    color: Constans.fourthColor,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      title: Text(
                        item.fullName!,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Constans.textColor,
                        ),
                      ),
                      subtitle: Text(
                        item.phoneNumbers!.first,
                        style: TextStyle(
                          fontSize: 15,
                          color: Constans.textColor,
                        ),
                      ),
                      trailing: Icon(
                        Icons.phone_android,
                        color: Constans.textColor,
                        size: 30,
                      ),
                      leading: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 60,
                        child: Text(
                          item.fullName!.split("").first,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        : Container();
  }
}
