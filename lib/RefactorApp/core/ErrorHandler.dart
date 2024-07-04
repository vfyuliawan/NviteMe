import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorHandler {
  Future<void> errorResponse({
    required String message,
    String? title,
    String? errorMessage,
    bool? dismissable,
  }) async {
    final String msg = errorMessage ?? message;
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> tokenExpired({
    required String message,
    String? title,
  }) async {
    final String msg = message;
    Fluttertoast.showToast(
      msg: title ?? 'Session Expired\n$msg',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

final ErrorHandler errorHandler = ErrorHandler();
