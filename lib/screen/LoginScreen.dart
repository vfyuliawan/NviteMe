// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w600),
        title: Text("Login Screen"),
        backgroundColor: Constans.secondaryColor,
      ),
    );
  }
}
