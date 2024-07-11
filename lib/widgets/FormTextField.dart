// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';

class FormTextField extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final String labelText;
  final int? line;
  final double? topSpace;
  final bool? enable;
  final Color? valueColor;
  final Color? labelColor;
  final Color? borderColor;
  final double? labelSize;
  final Widget? suffix;
  final Color? fillColor;
  final bool? obscureText;
  final double? height;

  const FormTextField({
    Key? key,
    this.initialValue = "",
    required this.onChanged,
    required this.labelText,
    this.line,
    this.topSpace,
    this.enable,
    this.suffix,
    this.fillColor,
    this.obscureText,
    this.height,
    this.labelColor,
    this.borderColor,
    this.labelSize,
    this.valueColor,
  }) : super(key: key);

  @override
  _FormTextFieldState createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? "");
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            widget.labelText,
            style: TextStyle(
                color: widget.labelColor ?? Colors.black,
                fontSize: widget.labelSize ?? 18),
          ),
        ),
        Container(
          height: widget.height,
          margin: EdgeInsets.only(top: widget.topSpace ?? 12),
          child: TextField(
            controller: _controller,
            onChanged: widget.onChanged,
            enabled: widget.enable ?? true,
            maxLines: widget.line ?? 1,
            style: TextStyle(
                fontSize: 14, color: widget.valueColor ?? Colors.black54),
            obscureText: widget.obscureText ?? false,
            focusNode: _focusNode,
            decoration: InputDecoration(
              fillColor:
                  widget.enable == true ? Colors.white : Colors.grey.shade200,
              filled: true,
              labelText: _focusNode.hasFocus ? null : null,
              suffixIconColor: Constans.textColor,
              suffixStyle:
                  TextStyle(color: Colors.amber, backgroundColor: Colors.amber),
              suffix: widget.suffix,
              labelStyle: TextStyle(
                  fontSize: 14, color: widget.labelColor ?? Colors.black),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: widget.borderColor ?? Constans.sixth),
                borderRadius: BorderRadius.circular(10.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: widget.borderColor ?? Constans.sixth),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: widget.borderColor ?? Constans.sixth),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
