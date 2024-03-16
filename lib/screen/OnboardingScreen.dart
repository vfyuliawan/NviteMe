// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/AuthController.dart';
import 'package:nvite_me/screen/LoginScreen.dart';
import 'package:nvite_me/screen/RootPage.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

final PageController _pageController = PageController(initialPage: 0);
int currentIndex = 0;

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: InkWell(
              onTap: () async {
                AuthController().getUserInfoLogin().then((value) {
                  if (value != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RootPage(),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    );
                  }
                });
              },
              child: Text(
                "Skip",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: const [
              CreatePage(
                image: 'assets/images/onboarding_sec.png',
                description: 'Learn How to Create Digital Invitation',
                title: 'Learn More About Digital Invitation',
              ),
              CreatePage(
                image: 'assets/images/onboarding.png',
                description: 'Create Invitation Landing Page Easier',
                title: 'Easy To Use',
              ),
              CreatePage(
                image: 'assets/images/onboarding_thrd.png',
                description: 'Learn How to Create Digital Invitation',
                title: 'Learn More About Digital Invitation',
              ),
            ],
          ),
          Positioned(
            child: Row(children: _buildIndicator()),
            bottom: 80,
            left: 30,
          ),
          Positioned(
            child: Container(
              child: IconButton(
                onPressed: () => {
                  setState(() {
                    if (currentIndex < 2) {
                      currentIndex++;
                      if (currentIndex < 3) {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.bounceIn);
                      }
                    } else {
                      AuthController().getUserInfoLogin().then((value) {
                        if (value != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RootPage(),
                            ),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        }
                      });
                    }
                  })
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Constans.secondaryColor),
            ),
            bottom: 60,
            right: 30,
          )
        ],
      ),
    );
  }
}

class CreatePage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const CreatePage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 50,
        right: 50,
        bottom: 80,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 350,
            child: Image(image: AssetImage(image)),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Constans.secondaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w900),
          )
        ],
      ),
    );
  }
}

Widget _indicator(bool isActive) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    height: 10,
    width: isActive ? 20 : 8,
    margin: EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
        color: Constans.secondaryColor, borderRadius: BorderRadius.circular(5)),
  );
}

List<Widget> _buildIndicator() {
  List<Widget> indicator = [];
  for (var i = 0; i < 3; i++) {
    if (currentIndex == i) {
      indicator.add(_indicator(true));
    } else {
      indicator.add(_indicator(false));
    }
  }

  return indicator;
}
