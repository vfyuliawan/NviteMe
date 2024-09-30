// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';

class IBodyRoundedWidget extends StatelessWidget {
  final Widget widget;
  final Color bodyColor;
  IBodyRoundedWidget({
    super.key,
    required this.widget,
    required this.bodyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 200,
            child: AppBar(
              backgroundColor: Constans.secondaryColor,
              title: Column(
                children: [
                  Text(
                    "Create Preset Template",
                    style:
                        TextStyle(color: Colors.white, fontFamily: "Pacifico"),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 110,
          left: 0,
          right: 0,
          child: Container(
              height: MediaQuery.of(context).size.height - 110,
              decoration: BoxDecoration(
                color: bodyColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  child: widget)),
        ),
      ],
    );
  }
}
