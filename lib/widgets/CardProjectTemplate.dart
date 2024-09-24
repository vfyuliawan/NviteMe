import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';
import 'package:nvite_me/RefactorApp/utility/Utilities.dart';

class CardProjectTemplate extends StatelessWidget {
  const CardProjectTemplate({
    super.key,
    required this.item,
    required this.name,
    required this.context,
  });

  final ListProject item;
  final String name;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(
          '/home/templateDetail/${item.id}',
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 25),
        height: 200,
        width: 260,
        decoration: BoxDecoration(
          color: Utilities().cekColor(item.theme.theme),
          image: DecorationImage(
              opacity: 0.4,
              image: NetworkImage(item.heroImage),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(
            40,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -30,
              left: -30,
              child: Container(
                height: 160,
                padding: EdgeInsets.only(right: 10),
                child: Center(
                  child: Container(
                    width: 60,
                    child: Text(
                      textAlign: TextAlign.start,
                      name,
                      style: TextStyle(
                          color: Utilities().cekColor(item.theme.theme),
                          fontSize: 12,
                          fontFamily: "Pacifico"),
                    ),
                  ),
                ),
                width: 160,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80)),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 140,
                child: Image.asset(
                    "assets/images/theme/${item.theme.theme}.png",
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
