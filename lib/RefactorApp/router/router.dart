// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import 'package:nvite_me/RefactorApp/moduls/after-login/home/bloc/home_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/home/home_screen.dart';
// import 'package:nvite_me/RefactorApp/moduls/after-login/list_project/bloc/list_project_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/list_project/cubit/list_project_cubit.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/list_template/cubit/list_template_cubit.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/list_template/list_template_screen.dart';
// import 'package:nvite_me/RefactorApp/moduls/after-login/main_menu/bloc/main_menu_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/project/detail_project_template.dart/bloc/detail_project_template_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/project/detail_project_template.dart/detail_project_template_screen.dart';
// import 'package:nvite_me/RefactorApp/moduls/after-login/user/bloc/user_bloc.dart';
// import 'package:nvite_me/RefactorApp/moduls/example/testComponent.dart';
import 'package:nvite_me/RefactorApp/moduls/pre-login/login/login_screen.dart';

import '../moduls/after-login/list_project/list_project_screen.dart';
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
              return HomeScreen();
            },
            routes: [
              GoRoute(
                path: 'templateDetail/:id',
                builder: (BuildContext context, GoRouterState state) {
                  return BlocProvider(
                    create: (context) {
                      final idParam = state.pathParameters['id']!;
                      final detailBloc = DetailProjectTemplateBloc();
                      detailBloc.add(
                          GetProjectDetailSample(id: idParam, contex: context));
                      return detailBloc;
                    },
                    child: DetailProjectTemplateScreen(),
                  );
                },
              ),
              GoRoute(
                path: 'listProject/:isMyProject',
                builder: (BuildContext context, GoRouterState state) {
                  return BlocProvider(
                    create: (context) {
                      final isMyProject = state.pathParameters['isMyProject'];
                      final listProjectBloc = ListProjectCubit();
                      listProjectBloc.getProject("");
                      return listProjectBloc;
                    },
                    child: ListProjectScreen(),
                  );
                },
              ),
              GoRoute(
                path: 'listTemplate',
                builder: (BuildContext context, GoRouterState state) {
                  return BlocProvider(
                    create: (context) {
                      final listTemplateCubit = ListTemplateCubit();
                      listTemplateCubit.getFirstProject("", context);
                      return listTemplateCubit;
                    },
                    child: ListTemplateScreen(),
                  );
                },
              ),
            ],
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
              return ListProjectScreen();
            },
          ),
        ],
      ),
    ],
  );
}
