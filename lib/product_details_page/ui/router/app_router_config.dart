import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_route_constants.dart';
import '../views/add_training.dart';
import '../views/list_trainings.dart';

class NyAppRouter {
  static GoRouter returnRouter() {
    GoRouter router = GoRouter(routes: [
      GoRoute(
        name: MyAppRouteConstants.addTrainingRouteName,
        path: '/addTraining',
        pageBuilder: (context, state) {
          return const MaterialPage(child: AddTraining());
        },
      ),
      GoRoute(
        name: MyAppRouteConstants.listTrainingsRouteName,
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: ListTrainings());
        },
      )
    ]);
    return router;
  }
}
