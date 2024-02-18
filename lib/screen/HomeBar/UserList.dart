// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/AuthController.dart';
import 'package:nvite_me/controller/OurProjectController.dart';
import 'package:nvite_me/model/UserIdModel.dart';
import 'package:nvite_me/model/UserLoginModel.dart';
import 'package:nvite_me/screen/AddUser/AddProjectScreen.dart';
import 'package:nvite_me/screen/DetailUserScreen.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late bool isOpenDashboard;
  late String uid;
  @override
  void initState() {
    super.initState();
    isOpenDashboard = true;
    uid = "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserLoginModel>(
      future: AuthController().getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          uid = snapshot.data!.uid!;
          return _listWidget(uid);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _listWidget(String uid) {
    return Scaffold(
      body: StreamBuilder(
        stream: OurProjectController().getAlldata(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                child: Text(
                  "error ${snapshot}",
                ),
              ),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text("Tidak Ada Data"),
            );
          } else {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Constans.secondaryColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Project   ",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 25,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  child: Container(
                    height: isOpenDashboard ? 400 : 150,
                    decoration: BoxDecoration(
                        color: Constans.thirdColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        )),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "    Find Your Project",
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              color: Colors.black38),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: 300,
                                child: TextField(
                                  decoration: InputDecoration(
                                    fillColor: Constans.thirdColor,
                                    filled: true,
                                    labelText: "Search",
                                    prefixIcon: Icon(
                                      Icons.search_outlined,
                                      size: 40,
                                    ),
                                    labelStyle: TextStyle(
                                        fontSize: 20, color: Colors.black38),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Constans.thirdColor),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddUserScreen(),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.add_box_rounded,
                                color: Constans.secondaryColor,
                                size: 65,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isOpenDashboard = !isOpenDashboard;
                            });
                          },
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 13,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "View Dashboard",
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black38),
                                  ),
                                  isOpenDashboard
                                      ? Icon(
                                          Icons.arrow_drop_down,
                                          size: 40,
                                          color: Colors.black38,
                                        )
                                      : Icon(
                                          Icons.arrow_left,
                                          size: 40,
                                          color: Colors.black38,
                                        )
                                ],
                              )),
                        ),
                        isOpenDashboard
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 120,
                                    width: 170,
                                    decoration: BoxDecoration(
                                      color: Constans.secondaryColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(0),
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.monitor_heart_rounded,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "Your Limit",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "20",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 120,
                                    width: 170,
                                    decoration: BoxDecoration(
                                      color: Constans.secondaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(0),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.monetization_on_outlined,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "Play Adsense",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "USD. 8.122",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: isOpenDashboard ? 310 : 210,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Constans.fourthColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        )),
                    width: MediaQuery.of(context).size.width,
                    height: isOpenDashboard ? 550 : 640,
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "List of Your Project (${snapshot.data!.length})",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    Column(
                                      children: snapshot.data!.map((item) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailUserScreen(
                                                        detailUser: item),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            margin: EdgeInsets.only(top: 15),
                                            color: Colors.white,
                                            child: ListTile(
                                              trailing: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: Constans.secondaryColor,
                                              ),
                                              leading: Container(
                                                  child: Image.asset(
                                                "assets/images/theme/${item.themeName}.png",
                                                fit: BoxFit.fill,
                                                height: 90,
                                                width: 80,
                                              )),
                                              title: Text(
                                                'Nama ${item.slug!}',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    color:
                                                        Constans.secondaryColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Tema : ${item.themeName!}',
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Text(
                                                            "Active",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .redAccent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Text(
                                                            "14 - Aug - 2025",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(
                                      height: 100,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            top: 0, right: -200, child: BackgroundWidget()),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 100),
      child: Container(
        alignment: Alignment.centerLeft,
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "    Find Your Project",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  color: Colors.black38),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Constans.thirdColor,
                      filled: true,
                      labelText: "Search",
                      prefixIcon: Icon(
                        Icons.search_outlined,
                        size: 40,
                      ),
                      labelStyle:
                          TextStyle(fontSize: 20, color: Colors.black38),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Constans.thirdColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.add_box_rounded,
                  color: Constans.secondaryColor,
                  size: 65,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Transform.rotate(
        angle: -50 * (3.141592653589793 / 180), // Convert degrees to radians
        child: Transform(
          transform: Matrix4.rotationY(
              180 * (3.141592653589793 / 180)), // Mirror horizontally
          child: Opacity(
            opacity: 0.4,
            child: Image.asset('assets/icons/flower.png'),
          ),
        ),
      ),
    );
  }
}

class UserListWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snapshot;
  const UserListWidget({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        List<UserIdModel> user = snapshot.data ?? [];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailUserScreen(detailUser: user[index]),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            child: ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Constans.secondaryColor,
              ),
              leading:
                  Container(child: Image.asset("assets/images/onboarding.png")),
              title: Text(
                'Nama ${user[index].slug!}',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Constans.secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tema : ${user[index].themeName!}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Active",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "14 - Aug - 2025",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class WidgetCountUser extends StatelessWidget {
  const WidgetCountUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Constans.thirdColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(children: [
                  Icon(
                    Icons.accessibility_outlined,
                    size: 40,
                  ),
                  Text("Total User 1")
                ]),
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Constans.thirdColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Column(children: [
                  Icon(
                    Icons.accessibility_outlined,
                    size: 40,
                  ),
                  Text("Total User 1")
                ]),
              ),
            ],
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
        color: Constans.secondaryColor,
      ),
    );
  }
}
