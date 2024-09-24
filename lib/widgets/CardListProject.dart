// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';

class CardListProject extends StatelessWidget {
  final List<ListProject> detailProject;
  final int index;

  const CardListProject({
    super.key,
    required this.detailProject,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded corners
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Image.network(
                detailProject[index].heroImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              // Description on top
              Positioned(
                bottom: 10,
                left: 15,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        detailProject[index].title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w800 // Customize text size
                            ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        maxLines: 4,
                        detailProject[index].quotes,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w300 // Customize text size
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
