// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';

class TearmCondition extends StatefulWidget {
  const TearmCondition({Key? key}) : super(key: key);

  @override
  _TearmConditionState createState() => _TearmConditionState();
}

class _TearmConditionState extends State<TearmCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],
        ),
      )),
    );
  }
}
