// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/screen/HomeBar/TearmCondition.dart';
import 'package:nvite_me/screen/HomeBar/ThemeScreen.dart';
import 'package:nvite_me/screen/HomeBar/UserList.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin {
  int _bottomNavIndex = 0;

  List<IconData> iconList = [
    Icons.tablet_android,
    Icons.palette_outlined,
    Icons.info,
  ];

  List<String> titleList = [
    "Home",
    "About",
  ];

  late AnimationController _animationController;
  late Animation<double> _notchAndCornersAnimation;
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      UserList(),
      ThemeScreen(),
      TearmCondition(),
    ];

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _notchAndCornersAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomNavIndex,
        children: pages,
      ),
      bottomNavigationBar: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(50), // Adjust the radius as needed
          ),
          child: AnimatedBottomNavigationBar(
            iconSize: 25,
            elevation: 0.0,
            backgroundColor: Constans.secondaryColor,
            splashColor: Colors.white,
            activeColor: Colors.white,
            inactiveColor: Colors.black.withOpacity(0.5),
            icons: iconList,
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.none,
            blurEffect: true,
            notchAndCornersAnimation: _notchAndCornersAnimation,
            notchSmoothness: NotchSmoothness.smoothEdge,
            onTap: (index) {
              setState(() {
                _bottomNavIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
