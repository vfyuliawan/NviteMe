// ignore_for_file: public_member_api_docs, sort_constructors_first, sort_child_properties_last
// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nvite_me/constans.dart';

class MultipleImageAdd extends StatefulWidget {
  final String? label;
  final List<File>? imagesFile;
  final List<String>? images;
  final ValueChanged<List<File>> pickedImage;
  final String slug;

  const MultipleImageAdd({
    Key? key,
    required this.label,
    this.imagesFile,
    this.images,
    required this.pickedImage,
    required this.slug,
  }) : super(key: key);

  @override
  _MultipleImageAddState createState() => _MultipleImageAddState();
}

class _MultipleImageAddState extends State<MultipleImageAdd> {
  List<File>? pickedImages = [];

  Future<void> onPickImages() async {
    try {
      List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(
        imageQuality: 8,
      );

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        setState(() {
          pickedImages = pickedFiles.map((file) => File(file.path)).toList();
          widget.pickedImage(pickedImages!);
          // widget.
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
              borderRadius: BorderRadius.circular(12),
            ),
            width: 550,
            child: Stack(alignment: Alignment.topLeft, children: [
              if (pickedImages != null)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Row(
                          children: widget.imagesFile!
                              .map((item) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.file(
                                            item,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              print(
                                                  'Close button tapped for image: $item');
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList()),
                      Row(
                        children: pickedImages!
                            .map(
                              (item) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(
                                        item,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Positioned(
                                      top:
                                          0, // Adjust the top position to add some margin
                                      right:
                                          0, // Adjust the right position to add some margin
                                      child: GestureDetector(
                                        onTap: () {
                                          print(
                                              'Close button tapped for image: ');
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                )
              else if (widget.images!.isNotEmpty)
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.images!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              widget.imagesFile![index],
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              else
                Center(child: CircularProgressIndicator()),
              InkWell(
                onTap: () {
                  onPickImages();
                },
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
            ]),
          ),
        ],
      ),
    );
  }
}
