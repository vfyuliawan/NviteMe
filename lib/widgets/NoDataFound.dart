// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NoDataFoundWidget extends StatefulWidget {
  const NoDataFoundWidget({Key? key}) : super(key: key);

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
              height: 30,
            ),
            Image.asset("assets/images/no-data.png"),
            Text(
              "Data Not Found",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
