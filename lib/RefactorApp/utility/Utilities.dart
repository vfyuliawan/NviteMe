import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nvite_me/constans.dart';

class Utilities {
  Future<bool?> showMessage({String? message}) {
    return Fluttertoast.showToast(
        msg: message ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Constans.sixth,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
