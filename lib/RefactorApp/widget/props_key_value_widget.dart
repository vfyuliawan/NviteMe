// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nvite_me/RefactorApp/domain/model/general/props_key_value.dart';

class PropsKeyValueWidget extends StatelessWidget {
  const PropsKeyValueWidget({
    super.key,
    required this.data,
  });

  final List<PropsKeyValue> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
          children: data.map((item) {
        return Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.key,
                    style: TextStyle(fontFamily: "Roboto-Medium", fontSize: 15),
                  ),
                ),
                Expanded(
                  child: Text(
                    item.value == "" ? "-" : item.value,
                    style: TextStyle(fontFamily: "Roboto-Medium", fontSize: 15),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: Colors.black,
              height: 10,
              thickness: 2,
            )
          ],
        );
      }).toList()),
    );
  }
}
