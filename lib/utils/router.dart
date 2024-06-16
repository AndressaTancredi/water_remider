import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/details_screen.dart';
import '../ui/home_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const WaterHomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'details',
            builder: (BuildContext context, GoRouterState state) {
              return const DetailsScreen();
            },
          ),
        ],
      ),
    ],
  );
}
