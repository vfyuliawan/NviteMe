// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nvite_me/constans.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Utility {
  static final logger = Logger(
    printer: PrettyPrinter(),
  );

  static final loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  String extractPathFromUrl(String url) {
    try {
      List<String> pathSegments = url.split('/');

      int filesIndex = pathSegments.indexOf('files');

      String convertedPath = pathSegments.sublist(filesIndex).join('/');

      return convertedPath;
    } catch (e) {
      print('Error converting URL path: $e');
      return '';
    }
  }

  String removeSpaces(String phoneNumber) {
    String cleanedPhoneNumber =
        phoneNumber.replaceAll(' ', '').replaceAll('-', '');
    if (cleanedPhoneNumber.startsWith('0')) {
      return '+62${cleanedPhoneNumber.substring(1)}';
    } else {
      return cleanedPhoneNumber;
    }
  }

  void openWebBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void themeAlert(
      {required BuildContext context,
      required String title,
      required String subtitle,
      bool? isError,
      Function? callback}) {
    Alert(
      context: context,
      type: isError ?? false ? AlertType.error : AlertType.success,
      title: title,
      style: AlertStyle(
        backgroundColor: Constans.alertColor,
        titleStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        descStyle: TextStyle(fontSize: 16),
      ),
      desc: subtitle,
      buttons: [
        DialogButton(
          color: Constans.secondaryColor,
          child: Text(
            "Lanjut",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () async {
            callback!();
          },
          width: 120,
        )
      ],
    ).show();
  }

  Future<void> savePref(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> savePrefModel(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

// Retrieve data from SharedPreferences
  Future<String?> loadPref({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  void deletePreference({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
