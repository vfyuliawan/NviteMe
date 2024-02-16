// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nvite_me/constans.dart';

class ImageComponent extends StatefulWidget {
  final String? label;
  final String? img;
  final ValueChanged<File> pickedImage;

  const ImageComponent({
    Key? key,
    required this.label,
    this.img,
    required this.pickedImage,
  }) : super(key: key);

  @override
  _ImageComponentState createState() => _ImageComponentState();
}

class _ImageComponentState extends State<ImageComponent> {
  File? pickedImage;

  Future<void> onPickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          pickedImage = File(pickedFile.path);
          widget.pickedImage(File(pickedImage!.path));
        });
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
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 250,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black54),
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
                            child: Image.network(
                              widget.img!,
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
