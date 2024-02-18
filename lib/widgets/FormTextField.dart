// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final String labelText;
  final int? line;
  final double? topSpace;
  final bool? enable;
  final bool? sufix;
  final Color? fillColor;
  final bool? obscureText;

  const FormTextField({
    Key? key,
    this.initialValue = "",
    required this.onChanged,
    required this.labelText,
    this.line,
    this.topSpace,
    this.enable,
    this.sufix,
    this.fillColor,
    this.obscureText,
  }) : super(key: key);

  @override
  _FormTextFieldState createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: widget.topSpace ?? 12),
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,
        enabled: widget.enable ?? true,
        maxLines: widget.line ?? 1,
        style: TextStyle(fontSize: 14),
        obscureText: widget.obscureText ?? false,
        decoration: InputDecoration(
          fillColor: widget.fillColor ?? Colors.white,
          filled: true,
          labelText: widget.labelText,
          suffixIconColor: Colors.blue,
          suffix: widget.sufix == true
              ? Icon(
                  Icons.copy,
                  size: 32,
                  color: Colors.blue,
                )
              : null,
          labelStyle: TextStyle(fontSize: 14),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black26),
            borderRadius: BorderRadius.circular(10.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black26),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
