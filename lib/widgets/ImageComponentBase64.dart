// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nvite_me/constans.dart';

class ImageComponentBase64 extends StatefulWidget {
  final String? label;
  final String? img;
  final ValueChanged<String> pickedImageBase64;

  const ImageComponentBase64({
    Key? key,
    required this.label,
    this.img,
    required this.pickedImageBase64,
  }) : super(key: key);

  @override
  _ImageComponentBase64State createState() => _ImageComponentBase64State();
}

class _ImageComponentBase64State extends State<ImageComponentBase64> {
  File? pickedImage;

  Future<void> onPickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await File(pickedFile.path).readAsBytes();
        final base64String = base64Encode(bytes);

        setState(() {
          pickedImage = File(pickedFile.path);
        });

        widget.pickedImageBase64(base64String);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label!,
            style: TextStyle(fontSize: 14, color: Constans.secondaryColor),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 250,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Constans.secondaryColor),
                borderRadius: BorderRadius.circular(12)),
            width: 550,
            child: Stack(alignment: Alignment.topLeft, children: [
              pickedImage != null
                  ? Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          pickedImage!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : widget.img == null
                      ? Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 100),
                            child: Text(
                              "Input Some Image",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        )
                      : Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.memory(
                              base64Decode(widget.img!),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
              InkWell(
                onTap: () {
                  onPickImage();
                },
                child: Center(
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constans.secondaryColor,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.add_photo_alternate,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
