// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nvite_me/constans.dart';

import 'dart:io' show Platform;

class IBodyRoundedWidget extends StatelessWidget {
  final Widget widget;
  final Color bodyColor;
  final String titleAppBar;
  final Function goBack;
  IBodyRoundedWidget({
    super.key,
    required this.widget,
    required this.bodyColor,
    required this.titleAppBar,
    required this.goBack,
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
              leading: GestureDetector(
                onTap: () {
                  goBack();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              actions: [],
              backgroundColor: Constans.secondaryColor,
              title: Text(
                titleAppBar,
                style: TextStyle(color: Colors.white, fontFamily: "Pacifico"),
              ),
            ),
          ),
        ),
        Positioned(
          top: Platform.isIOS ? 120 : 100,
          left: 0,
          right: 0,
          child: Container(
              height: MediaQuery.of(context).size.height -
                  (Platform.isIOS ? 120 : 100),
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
