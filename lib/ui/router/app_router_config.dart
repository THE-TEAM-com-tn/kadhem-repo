import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_trainings/ui/views/error_view.dart';

import 'app_route_constants.dart';

import '../views/home_view.dart';
import '../views/add_training.dart';
import '../views/list_trainings.dart';

class NyAppRouter {
  static GoRouter returnRouter() {
    GoRouter router = GoRouter(
        routes: [
          GoRoute(
            name: MyAppRouteConstants.homeRouteName,
            path: '/',
            pageBuilder: (context, state) {
              return const MaterialPage(child: HomeView());
            },
          ),
          GoRoute(
            name: MyAppRouteConstants.addTrainingRouteName,
            path: '/addTraining',
            pageBuilder: (context, state) {
              return const MaterialPage(child: AddTraining());
            },
          ),
          GoRoute(
            name: MyAppRouteConstants.listTrainingsRouteName,
            path: '/listTrainings',
            pageBuilder: (context, state) {
              return const MaterialPage(child: ListTrainings());
            },
          )
        ],
        errorPageBuilder: (context, state) {
          return const MaterialPage(child: ErrorView());
        });
    return router;
  }
}
