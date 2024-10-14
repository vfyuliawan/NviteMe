// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/contact/contact_screen.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/create_preset/create_preset_screen.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/create_preset/cubit/create_preset_cubit.dart';
// import 'package:nvite_me/RefactorApp/moduls/after-login/home/bloc/home_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/home/home_screen.dart';
// import 'package:nvite_me/RefactorApp/moduls/after-login/list_project/bloc/list_project_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/list_project/cubit/list_project_cubit.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/list_template/cubit/list_template_cubit.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/list_template/list_template_screen.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/project/create_project/create_project_screen.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/project/create_project/cubit/create_project_cubit.dart';
// import 'package:nvite_me/RefactorApp/moduls/after-login/main_menu/bloc/main_menu_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/project/detail_project_template.dart/bloc/detail_project_template_bloc.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/project/detail_project_template.dart/detail_project_template_screen.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/web_view/web_view_screen.dart';
// import 'package:nvite_me/RefactorApp/moduls/after-login/user/bloc/user_bloc.dart';
// import 'package:nvite_me/RefactorApp/moduls/example/testComponent.dart';
import 'package:nvite_me/RefactorApp/moduls/pre-login/login/login_screen.dart';
import 'package:nvite_me/constans.dart';

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
                path: 'listTemplate/:isHome',
                builder: (BuildContext context, GoRouterState state) {
                  final isHomeParam = state.pathParameters['isHome'];
                  print(isHomeParam);
                  return BlocProvider(
                    create: (context) {
                      final listTemplateCubit = ListTemplateCubit();
                      listTemplateCubit.getFirstProject("", context);
                      return listTemplateCubit;
                    },
                    child: ListTemplateScreen(isHome: isHomeParam == "true"),
                  );
                },
              ),
              GoRoute(
                path: Constans.routeMenu.createPreset,
                builder: (BuildContext context, GoRouterState state) {
                  return BlocProvider(
                    create: (context) {
                      final createPresetCubit = CreatePresetCubit();
                      // listTemplateCubit.getFirstProject("", context);
                      return createPresetCubit;
                    },
                    child: const CreatePresetScreen(),
                  );
                },
              ),
              GoRoute(
                path: Constans.routeMenu.listcontact,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    transitionDuration: Duration(milliseconds: 1000),
                    key: state.pageKey,
                    child: ContactScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      // Define the offset for the slide transition
                      const begin = Offset(0.0, 1.0); // Start from the bottom
                      const end = Offset.zero; // End at the original position
                      const curve = Curves.easeIn; // Use the desired curve

                      // Apply the animation for position
                      var slideTween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var slideAnimation = animation.drive(slideTween);

                      // Apply the animation for opacity
                      var opacityTween = Tween(begin: 0.0, end: 1.0);
                      var opacityAnimation =
                          opacityTween.animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeIn,
                      ));

                      return SlideTransition(
                        position: slideAnimation,
                        child: FadeTransition(
                          opacity: opacityAnimation,
                          child: child,
                        ),
                      );
                    },
                  );
                },
              ),
              GoRoute(
                path: 'webView/:slug',
                builder: (BuildContext context, GoRouterState state) {
                  final slugContent = state.pathParameters["slug"];
                  return WebViewScreen(slug: slugContent!);
                },
              ),
              GoRoute(
                  path: Constans.routeMenu.createUndangan,
                  builder: (BuildContext context, GoRouterState state) {
                    return BlocProvider(
                      create: (context) {
                        final cubit = CreateProjectCubit();
                        return cubit;
                      },
                      child: CreateProjectScreen(),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'listTemplate/:isHome',
                      builder: (BuildContext context, GoRouterState state) {
                        final isHomeParam = state.pathParameters['isHome'];
                        print(isHomeParam);
                        return BlocProvider(
                          create: (context) {
                            final listTemplateCubit = ListTemplateCubit();
                            listTemplateCubit.getFirstProject("", context);
                            return listTemplateCubit;
                          },
                          child:
                              ListTemplateScreen(isHome: isHomeParam == "true"),
                        );
                      },
                    ),
                  ]),
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
