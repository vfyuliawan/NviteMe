import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/theme_example/model_get_theme_example.dart';
import 'package:nvite_me/RefactorApp/utility/Utilities.dart';

class CardProjectTemplate extends StatelessWidget {
  const CardProjectTemplate({
    super.key,
    required this.item,
    required this.name,
    required this.context,
  });

  final ListTheme item;
  final String name;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 25),
      height: 200,
      width: 260,
      decoration: BoxDecoration(
        color: Color(int.parse(item.themeColor)),
        image: DecorationImage(
            opacity: 0.4, image: NetworkImage(item.bgImage), fit: BoxFit.cover),
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
              padding: const EdgeInsets.only(right: 10),
              width: 160,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(80)),
              child: Center(
                child: Container(
                  width: 60,
                  child: Text(
                    textAlign: TextAlign.start,
                    name,
                    style: TextStyle(
                        color: Color(int.parse(item.themeColor)),
                        fontSize: 12,
                        fontFamily: "Pacifico"),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: Container(
              height: 120,
              child: Image.network(item.fgImage, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
