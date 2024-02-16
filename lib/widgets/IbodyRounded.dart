// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';

class IbodyRounded extends StatefulWidget {
  const IbodyRounded({Key? key}) : super(key: key);

  @override
  _IbodyRoundedState createState() => _IbodyRoundedState();
}

class _IbodyRoundedState extends State<IbodyRounded> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Constans.secondaryColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Detail User   ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: Constans.thirdColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        )),
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: EdgeInsets.only(top: 90),
                      height: 50,
                      decoration: BoxDecoration(
                          color: Constans.fourthColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          )),
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 90, right: 20),
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
