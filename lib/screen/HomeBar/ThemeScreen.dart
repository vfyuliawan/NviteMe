// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_new
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  late bool loading = false;
  late bool enableApply = true;
  late bool isOpenBalance = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: loading
          ? Container(
              decoration: BoxDecoration(
                color: Constans.secondaryColor,
              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: Constans.fourthColor,
                ),
              ),
            )
          : Column(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            color: Constans.secondaryColor,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            margin: const EdgeInsets.only(top: 35),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  "Theme",
                                  style: TextStyle(
                                    fontFamily: 'Pacifico',
                                    fontWeight: FontWeight.w200,
                                    fontSize: 25,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          // height: MediaQuery.of(context).size.height - 170,
                          margin: const EdgeInsets.only(top: 80),
                          decoration: BoxDecoration(
                              color: Constans.thirdColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              )),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "List Theme Available",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: 'Pacifico',
                                          color: Constans.textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: const EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                    color: Constans.fourthColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                    )),
                                child: _listTheme(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _listTheme() {
    List<String> listTheme = Constans.listTheme;
    return Container(
      height: MediaQuery.of(context).size.height - 240,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1,
        ),
        itemCount: listTheme.length,
        itemBuilder: (BuildContext context, int index) {
          String theme = listTheme[index]; // Access the theme from the list
          return Card(
            elevation: 10,
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    AspectRatio(
                        aspectRatio: 1.5,
                        child: Image.asset("assets/images/theme/$theme.png")),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      theme,
                      style: TextStyle(
                          color: Constans.secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico'),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
