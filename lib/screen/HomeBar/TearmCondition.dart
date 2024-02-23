// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/AuthController.dart';
import 'package:nvite_me/screen/LoginScreen.dart';
import 'package:nvite_me/utils/utils.dart';

class TearmCondition extends StatefulWidget {
  const TearmCondition({Key? key}) : super(key: key);

  @override
  _TearmConditionState createState() => _TearmConditionState();
}

class _TearmConditionState extends State<TearmCondition> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            child: CircularProgressIndicator(),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          )
        : Scaffold(
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 23,
                  ),
                  Text(
                    "Caution",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Constans.secondaryColor),
                  ),
                  Container(
                      child: Text(
                    "This Application is under Development, you find this applicatioin is only you get download URL from the Developer,\n\n\nuse this application wisely",
                    style: TextStyle(fontSize: 14),
                  )),
                  SizedBox(
                    height: 200,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Constans.secondaryColor),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        await AuthController().signOut().then((value) {
                          setState(() {
                            loading = false;
                          });
                          Utility().themeAlert(
                            context: context,
                            title: "Berhasil Logout",
                            subtitle: "Sampai Jumpa Kembali.",
                            callback: () async {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => WillPopScope(
                                    onWillPop: () async {
                                      return false;
                                    },
                                    child: LoginScreen(),
                                  ),
                                ),
                              );
                            },
                          );
                        });
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 7),
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
                              'LogOut',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          );
  }
}
