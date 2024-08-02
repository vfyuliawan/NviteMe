// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, non_constant_identifier_names, sort_child_properties_last, unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/projects/model_response_project_sample.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/main_menu/bloc/main_menu_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/user/bloc/user_bloc.dart';
import 'package:nvite_me/RefactorApp/utility/Utilities.dart';
import 'package:nvite_me/constans.dart';

class MainMenuScreen extends StatelessWidget {
  MainMenuScreen({Key? key}) : super(key: key);

  List<Image> menuImage = [
    Image.asset("assets/icons/layout-2.png"),
    Image.asset("assets/icons/Hero.png"),
    Image.asset("assets/icons/user-2.png"),
    Image.asset("assets/icons/user.png"),
    Image.asset("assets/icons/stop.png"),
    Image.asset("assets/icons/waiting.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade300),
        child: Column(
          children: [
            UserInfo(context),
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<MainMenuBloc, MainMenuState>(
                  builder: (context, state) {
                    if (state is GetProjectTemplateIsSuccess) {
                      return Column(
                        children: [
                          ProjectTemplate(state.result, context),
                          Menu(),
                          YourProject(),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      );
                    } else if (state is MainMenuIsLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container YourProject() {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
      ),
      padding: EdgeInsets.all(
        20,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Project",
                style: TextStyle(
                  color: Constans.seventh,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "See More >",
                style: TextStyle(
                  color: const Color.fromARGB(255, 219, 125, 3),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 200,
                  width: 260,
                  child: Card(
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 200,
                  width: 260,
                  child: Card(
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 200,
                  width: 260,
                  child: Card(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container Menu() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Wrap(
        spacing: 20, // spacing between containers
        runSpacing: 20, // spacing between rows
        children: List.generate(menuImage.length, (index) {
          return Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.all(15),
            child: menuImage[index],
          );
        }),
      ),
    );
  }

  Widget ProjectTemplate(ResultProjectSample props, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
      ),
      padding: EdgeInsets.all(
        20,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Proect Template",
                style: TextStyle(
                  color: Constans.seventh,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "See More >",
                style: TextStyle(
                  color: const Color.fromARGB(255, 219, 125, 3),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: props.projects.map((item) {
                return CardTheme(item, item.title, context);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget CardTheme(Project item, String name, BuildContext context) {
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
                          fontSize: 16,
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

  Widget UserInfo(BuildContext context) {
    final nowDate = DateTime.now();
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserIsSuccess) {
          return Container(
            height: 230,
            child: Stack(
              children: [
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/icons/bg.png",
                      ),
                      fit: BoxFit.cover,
                      opacity: 0.4,
                    ),
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(50)),
                    color: Constans.seventh,
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 37,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.83,
                      height: 120,
                      margin: const EdgeInsets.only(
                          bottom: 30), // Adjust margin as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Constans.seventh, // Set the border color
                          width: 1, // Set the border width
                        ),
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.calendar_month,
                                  color: Colors.grey.shade600),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                nowDate.toString().split(" ")[0],
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Hallo, ${state.detailUser.name}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: Text(
                                  "Get ready to make your wedding app invitation",
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 50,
                  child: Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Constans.seventh, // Set the border color
                        width: 1, // Set the border width
                      ),
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(75 / 2),
                    ),
                    child: state.detailUser.photo == ""
                        ? const Icon(
                            Icons.supervised_user_circle_rounded,
                            color: Colors.black,
                            size: 55,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(150 / 2),
                            child: Image.memory(
                              base64Decode(state.detailUser.photo),
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
