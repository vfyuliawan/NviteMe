import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/widgets/IBodyRoundedWidget.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: IBodyRoundedWidget(
            widget: Container(),
            bodyColor: Constans.fourthColor,
            titleAppBar: "Contact",
            goBack: () {
              context.pop();
            }),
      ),
    );
  }
}
