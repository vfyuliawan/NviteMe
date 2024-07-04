// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nvite_me/constans.dart';

import 'bloc/onboarding_bloc_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: InkWell(
              onTap: () => context
                  .read<OnboardingBloc>()
                  .add(SkipEvent(context: context)),
              child: const Text(
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
          BlocBuilder<OnboardingBloc, OnboardingBlocState>(
            builder: (context, state) {
              return PageView(
                onPageChanged: (int page) {
                  context
                      .read<OnboardingBloc>()
                      .add(PageChangedEvent(pageIndex: page));
                },
                controller: context.read<OnboardingBloc>().pageController,
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
              );
            },
          ),
          Positioned(
            child: BlocBuilder<OnboardingBloc, OnboardingBlocState>(
              builder: (context, state) {
                return Row(
                  children: _buildIndicator(
                      context.read<OnboardingBloc>().currentIndex),
                );
              },
            ),
            bottom: 80,
            left: 30,
          ),
          Positioned(
            child: Container(
              child: IconButton(
                onPressed: () =>
                    context.read<OnboardingBloc>().add(NextPageEvent(context)),
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              padding: const EdgeInsets.all(5),
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

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Constans.secondaryColor,
          borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _buildIndicator(int currentIndex) {
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
          const SizedBox(
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
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w900),
          )
        ],
      ),
    );
  }
}
