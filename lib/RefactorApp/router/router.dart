import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/home/bloc/home_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/home/home_screen.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/project/list_project/list_project_screen.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/user/bloc/user_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/example/testComponent.dart';
import 'package:nvite_me/RefactorApp/moduls/pre-login/login/login_screen.dart';

import '../moduls/pre-login/onboarding/onboarding_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: "/",
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return LoginScreen();
            },
          ),
          GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => HomeBloc(),
                  ),
                  BlocProvider(
                    create: (context) {
                      final userBloc = UserBloc();
                      userBloc
                          .add(GetUserDetail(context)); // Dispatch the event
                      return userBloc;
                    },
                  ),
                ],
                child: HomeScreen(),
              );
            },
          ),
          GoRoute(
            path: 'test1',
            builder: (BuildContext context, GoRouterState state) {
              return const TestComponent();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/home1',
        builder: (BuildContext context, GoRouterState state) {
          return HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'listProject',
            builder: (BuildContext context, GoRouterState state) {
              return const ListProjectScreen();
            },
          ),
        ],
      ),
    ],
  );
}
