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

  Color cekColor(String themeNme) {
    if (themeNme == Constans.theme.redEssence) {
      return Constans.redEssence;
    } else if (themeNme == Constans.theme.bluePremium) {
      return Constans.bluePremium;
    } else if (themeNme == Constans.theme.luxuryCream) {
      return Constans.luxuryCream;
    } else if (themeNme == Constans.theme.luxuryGreen) {
      return Constans.luxuryGreen;
    } else if (themeNme == Constans.theme.luxuryPink) {
      return Constans.luxuryPink;
    } else {
      return Constans.primaryColor;
    }
  }
}
