// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, sort_child_properties_last, unused_local_variable, prefer_const_literals_to_create_immutables, avoid_print

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/home/bloc/home_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/main_menu/bloc/main_menu_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/main_menu/main_menu_screen.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/user/bloc/user_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/user/user_screen.dart';
import 'package:nvite_me/constans.dart';

class ConcaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width / 2, 100, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final List<IconData> iconList = [
    // Icons.tablet_android_rounded,
    Icons.palette_rounded,
    Icons.info_outline_rounded,
  ];

  final List<Widget> pages = [
    // UserScreen(),
    // BlocProvider(
    //   create: (context) {
    //     // final userBloc = UserBloc();
    //     // userBloc.add(GetUserDetail(context));
    //     // return userBloc;
    //     final mainMenuBLOC = MainMenuBloc();
    //     mainMenuBLOC.add(GetProjectSampele(context));
    //     return mainMenuBLOC;
    //   },
    //   child: MainMenuScreen(),
    // ),
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) {
          final userBloc = UserBloc();
          userBloc.add(GetUserDetail(context));
          return userBloc;
        },
      ),
      BlocProvider(
        create: (context) {
          final mainMenubloc = MainMenuBloc();
          mainMenubloc.add(GetProjectSampele(context));
          return mainMenubloc;
        },
      )
    ], child: MainMenuScreen()),
    BlocProvider(
      create: (context) {
        final userBloc = UserBloc();
        userBloc.add(GetUserDetail(context));
        return userBloc;
      },
      child: UserScreen(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeIsSuccess) {
                  return IndexedStack(
                    index: state.selectedIndex,
                    children: pages,
                  );
                }
                return Container();
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                int curentNavIndex = 1;
                if (state is HomeIsSuccess) {
                  curentNavIndex = state.selectedIndex;
                }
                return Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 130,
                    child: ClipPath(
                      clipper: ConcaveClipper(),
                      child: CustomNavBar(context, curentNavIndex),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AnimatedBottomNavigationBar Navbar(int curentNavIndex, BuildContext context) {
    return AnimatedBottomNavigationBar(
      iconSize: 35,
      elevation: 3,
      backgroundColor: Colors.white, // Replace with Constans.secondaryColor
      splashColor: Constans.textColor,
      activeColor: Constans.seventh,
      inactiveColor: Constans.seventh,
      icons: iconList,
      activeIndex: curentNavIndex,
      gapLocation: GapLocation.none,
      blurEffect: true,
      notchAndCornersAnimation: AlwaysStoppedAnimation(0.0), // Adjust as needed
      notchSmoothness: NotchSmoothness.smoothEdge,
      onTap: (index) {
        BlocProvider.of<HomeBloc>(context).add(BottomnavItemSelected(index));
      },
    );
  }

  Widget CustomNavBar(
    BuildContext context,
    int curentNavIndex,
  ) {
    List<Image> navImages = [
      Image.asset(
        "assets/icons/atm-card.png",
        fit: BoxFit.contain,
      ),
      Image.asset(
        "assets/icons/database.png",
        fit: BoxFit.contain,
      ),
      Image.asset(
        "assets/icons/user-2.png",
        fit: BoxFit.contain,
      ),
    ];

    List<Widget> navImagesIcon = [
      // Icon(
      //   Icons.home_filled,
      //   color: Colors.white,
      //   size: 27,
      // ),
      Column(
        children: [
          Icon(
            Icons.dashboard,
            color: Colors.white,
            size: 27,
          ),
          Text(
            "Menu",
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
      Column(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Colors.white,
            size: 27,
          ),
          Text(
            "Info",
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    ];
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Constans.seventh,
        image: DecorationImage(
            image: AssetImage(
              "assets/icons/bg.png",
            ), // Use different image for each index if needed
            fit: BoxFit.cover,
            opacity: 0.4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: navImagesIcon.asMap().entries.map((entry) {
          int index = entry.key;
          Widget image = entry.value;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<HomeBloc>(context)
                    .add(BottomnavItemSelected(index));
                print("Tapped on index: $index");
              },
              child: Container(
                height: 63,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 8),
                // margin: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      index == 0 ? 0 : 20,
                    ),
                    topRight: Radius.circular(
                      index == 0 ? 20 : 0,
                    ),
                  ),
                  color: index == curentNavIndex
                      ? Constans.thirdColor
                      : Colors.transparent,
                ),
                child: image,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
