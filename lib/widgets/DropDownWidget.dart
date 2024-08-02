// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';

class DropdownWidget extends StatefulWidget {
  final List<String>? list;
  final String? initial;
  final Function(String value) setValue;
  final IconData icon;
  final double? percentage;

  const DropdownWidget(
      {Key? key,
      required this.list,
      this.initial,
      required this.setValue,
      required this.icon,
      this.percentage = 0.87})
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
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Constans.secondaryColor,
          )),
      width: MediaQuery.of(context).size.width,
      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width * widget.percentage!,
        label: Text(
          widget.initial!,
          style: TextStyle(fontSize: 15, color: Constans.secondaryColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
        ),
        leadingIcon: Icon(
          widget.icon,
          color: Constans.secondaryColor,
        ),
        onSelected: (String? value) {
          setState(() {
            widget.setValue(value!);
          });
        },
        dropdownMenuEntries:
            widget.list!.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(
            value: value,
            label: value,
          );
        }).toList(),
      ),
    );
  }
}
