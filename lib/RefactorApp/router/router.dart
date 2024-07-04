import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nvite_me/RefactorApp/moduls/example/testComponent2.dart';

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
            path: 'detail',
            builder: (BuildContext context, GoRouterState state) {
              return const TestComponent2();
            },
          ),
        ],
      ),
    ],
  );
}
