// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/home/bloc/home_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/home/home_screen.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/main_menu/bloc/main_menu_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/project/detail_project_template.dart/bloc/detail_project_template_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/user/bloc/user_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/example/testComponent.dart';
import 'package:nvite_me/RefactorApp/moduls/pre-login/onboarding/bloc/onboarding_bloc_bloc.dart';
import 'package:nvite_me/RefactorApp/router/router.dart';

import 'RefactorApp/moduls/pre-login/onboarding/onboarding_screen.dart';

// void main() async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//   await Firebase.initializeApp();
//   await Future.delayed(const Duration(seconds: 3));
//   FlutterNativeSplash.remove();
//   GoogleSignIn();
//   GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: OnboardingScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

void main() async {
  runApp(MyAppRefactor());
}

class MyAppRefactor extends StatelessWidget {
  const MyAppRefactor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => OnboardingBloc(),
          ),
          BlocProvider(
            create: (context) => HomeBloc(),
          ),
          BlocProvider(
            create: (context) => UserBloc(),
          ),
          BlocProvider(
            create: (context) {
              final mainMenuBloc = MainMenuBloc();
              mainMenuBloc.add(GetProjectSampele(context));
              return mainMenuBloc;
            },
          ),
          BlocProvider(
            create: (context) => DetailProjectTemplateBloc(),
            child: Container(),
          )
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        ));
  }
}
