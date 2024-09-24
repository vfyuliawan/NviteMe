import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nvite_me/constans.dart';

class Utilities {
  final ImagePicker _picker = ImagePicker();

  Timer? _debounce;
  void debounceSearch(Function callBack, {int milliseconds = 500}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () {
      callBack();
    });
  }

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

  Future<String?> pickedImage() async {
    try {
      final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 70);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final fileSizeInBytes = await file.length();
        final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
        print(fileSizeInMB);
        print(pickedFile.mimeType);
        print(fileSizeInBytes);

        if (fileSizeInMB > 2) {
          Utilities()
              .showMessage(message: "Image size exceeds 2 MB, cannot upload.");
          return null;
        } else {
          final bytes = await pickedFile.readAsBytes();
          final base64Image = base64Encode(bytes);

          // Determine MIME type, default to image/jpeg if unknown
          final mimeType = pickedFile.mimeType ?? 'image/jpeg';
          final base64WithPrefix = 'data:$mimeType;base64,$base64Image';

          return base64WithPrefix;
        }
      } else {
        Utilities().showMessage(message: "No Image Selected");
        return null;
      }
    } catch (e) {
      Utilities().showMessage(message: e.toString());
      return null;
    }
  }
}
