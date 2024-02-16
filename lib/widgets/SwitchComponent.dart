// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';

class SwitchComponent extends StatefulWidget {
  final bool value;
  final String label;
  final ValueChanged<bool> onChange;
  const SwitchComponent(
      {Key? key,
      required this.value,
      required this.onChange,
      required this.label})
      : super(key: key);

  @override
  _SwitchComponentState createState() => _SwitchComponentState();
}

class _SwitchComponentState extends State<SwitchComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.label),
          Switch(
            value: (widget.value),
            activeColor: Constans.secondaryColor,
            onChanged: widget.onChange,
          ),
        ],
      ),
    );
  }
}
