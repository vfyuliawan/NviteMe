// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, non_constant_identifier_names, sort_child_properties_last, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/theme_example/model_get_theme_example.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/main_menu/bloc/main_menu_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/user/bloc/user_bloc.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/widgets/CardListProject.dart';
import 'package:nvite_me/widgets/CardProjectTemplate.dart';
import 'package:nvite_me/widgets/IImageBase64Component.dart';
import 'package:nvite_me/widgets/NoDataFound.dart';

class MainMenuScreen extends StatelessWidget {
  MainMenuScreen({Key? key}) : super(key: key);

  List<Map<String, dynamic>> menuAdmin = [
    {
      "icon": Image.asset("assets/icons/layout-2.png"),
      "title": "Create\nUndangan",
      "route": Constans.routeMenu.createUndangan,
    },
    {
      "icon": Image.asset("assets/icons/Hero.png"),
      "title": "Create\nPreset",
      "route": Constans.routeMenu.createPreset,
    },
    {
      "icon": Image.asset("assets/icons/user-2.png"),
      "title": "Contact",
      "route": Constans.routeMenu.listcontact,
    },
    {
      "icon": Image.asset("assets/icons/user.png"),
      "title": "User",
      "route": Constans.routeMenu.listUser,
    },
    {
      "icon": Image.asset("assets/icons/stop.png"),
      "title": "RSVP",
      "route": Constans.routeMenu.listRsvp,
    },
    {
      "icon": Image.asset("assets/icons/waiting.png"),
      "title": "Message",
      "route": Constans.routeMenu.listMessage,
    },
  ];

  List<Map<String, dynamic>> menuUser = [
    {
      "icon": Image.asset("assets/icons/Hero.png"),
      "title": "Create\nUndangan",
      "route": Constans.routeMenu.createUndangan,
    },
    {
      "icon": Image.asset("assets/icons/user-2.png"),
      "title": "Contact",
      "route": Constans.routeMenu.listcontact,
    },
    {
      "icon": Image.asset("assets/icons/stop.png"),
      "title": "RSVP",
      "route": Constans.routeMenu.listRsvp,
    },
    {
      "icon": Image.asset("assets/icons/waiting.png"),
      "title": "Message",
      "route": Constans.routeMenu.listMessage,
    },
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
                child: Column(
                  children: [
                    BlocBuilder<MainMenuBloc, MainMenuState>(
                      builder: (context, state) {
                        if (state is GetProjectTemplateIsSuccess) {
                          return Column(
                            children: [
                              ProjectTemplate(state.projectTemplate, context),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        } else if (state is MainMenuIsLoading) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserIsSuccess) {
                          print(state.detailUser.role);

                          if (state.detailUser.role == "ADMIN") {
                            return MenuAdmin(context);
                          } else {
                            return MenuUser(context);
                          }
                        }
                        return Container();
                      },
                    ),
                    YourProject(context),
                    SizedBox(
                      height: 150,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container YourProject(BuildContext context) {
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
              GestureDetector(
                onTap: () {
                  context.go("/home/listProject/${true}");
                },
                child: Text(
                  "See More Project >",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 219, 125, 3),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: BlocBuilder<MainMenuBloc, MainMenuState>(
              builder: (context, state) {
                if (state is GetProjectTemplateIsSuccess) {
                  final detailProject = state.myProject!.projects;
                  if (detailProject.isNotEmpty) {
                    return Row(
                      children: detailProject.asMap().entries.map((entry) {
                        int index = entry.key;
                        return Container(
                          width: 190,
                          height: 270, // Specify a fixed width for each item
                          child: CardListProject(
                            detailProject: detailProject,
                            index: index,
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return NoDataFoundWidget(
                      message:
                          "Anda Belum Memiliki undangan  \n Segera buat undangan anda",
                    );
                  }
                } else {
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Container MenuAdmin(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: List.generate(menuAdmin.length, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // ignore: prefer_interpolation_to_compose_strings
                  context.go("/home/" + menuAdmin[index]["route"]);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.all(15),
                  child: menuAdmin[index]["icon"],
                ),
              ),
              SizedBox(height: 4),
              Text(
                menuAdmin[index]["title"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Constans.secondaryColor,
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Container MenuUser(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: List.generate(menuUser.length, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  context.go("/home/${menuUser[index]["route"]}");
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.all(15),
                  child: menuUser[index]["icon"],
                ),
              ),
              SizedBox(height: 4),
              Text(
                menuUser[index]["title"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Constans.secondaryColor,
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget ProjectTemplate(ResultThemeExample props, BuildContext context) {
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
                "Preset",
                style: TextStyle(
                  color: Constans.seventh,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.go("/home/listTemplate");
                },
                child: Text(
                  "See More Preset >",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 219, 125, 3),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
              children: props.listTheme.map((item) {
                return CardProjectTemplate(
                  item: item,
                  name: item.themeName,
                  context: context,
                );
              }).toList(),
            ),
          ),
        ],
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
                            child: IImageBase64Component(
                                image: state.detailUser.photo,
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150)),
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
