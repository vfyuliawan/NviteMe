// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:nvite_me/model/HomeModel.dart';

class AboutPage extends StatefulWidget {
  final HomeModel? data;
  final String? slug;
  const AboutPage({Key? key, this.data, this.slug}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
