// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final List<String>? list;
  final String? initial;
  final Function(String value) setValue;
  final IconData icon;

  const DropdownWidget(
      {Key? key,
      required this.list,
      this.initial,
      required this.setValue,
      required this.icon})
      : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initial ?? widget.list?.first ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      width: MediaQuery.of(context).size.width,
      child: DropdownMenu<String>(
        width: 335,
        label: Text(
          widget.initial!,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        leadingIcon: Icon(
          widget.icon,
          color: Colors.black54,
        ),
        onSelected: (String? value) {
          setState(() {
            widget.setValue(value!);
          });
        },
        dropdownMenuEntries:
            widget.list!.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      ),
    );
  }
}
