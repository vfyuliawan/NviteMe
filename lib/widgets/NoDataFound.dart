// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';

class NoDataFoundWidget extends StatefulWidget {
  final String? message;
  final String? image;
  NoDataFoundWidget({Key? key, this.message, this.image}) : super(key: key);

  @override
  _NoDataFoundWidgetState createState() => _NoDataFoundWidgetState();
}

class _NoDataFoundWidgetState extends State<NoDataFoundWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 250,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Container(
              child: Image.asset(
                widget.image ?? "assets/icons/charfif.png",
                fit: BoxFit.cover,
              ),
              height: 170,
              width: 170,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.message ?? "Data Not Found",
              style: TextStyle(
                fontFamily: "Pacifico",
                color: Constans.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
