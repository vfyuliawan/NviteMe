// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class TestComponent extends StatelessWidget {
  const TestComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height + 100,
        decoration: BoxDecoration(color: Colors.amber),
        child: Center(child: Text("Test Component 1")),
      ),
    );
  }
}
