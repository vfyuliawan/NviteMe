import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/widgets/FormTextField.dart';

class FormTextFieldWithIcon extends StatelessWidget {
  final String labelText;
  final String initialValue;
  final String hintText;
  final Function onChange;
  final IconData icon;
  final Function onTapIcon;

  FormTextFieldWithIcon(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.onChange,
      required this.icon,
      required this.initialValue,
      required this.onTapIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: FormTextField(
            isIcon: true,
            topSpace: 4,
            enable: false,
            onChanged: (value) {
              onChange(value);
            },
            labelText: labelText,
            labelColor: Colors.black45,
            initialValue: initialValue,
            labelSize: 16,
            hintText: hintText,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: Column(
          children: [
            const SizedBox(
              height: 28,
            ),
            GestureDetector(
              onTap: () {
                onTapIcon();
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(23),
                decoration: BoxDecoration(
                    color: Constans.secondaryColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Icon(
                  icon,
                  color: Constans.fourthColor,
                  size: 16,
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
