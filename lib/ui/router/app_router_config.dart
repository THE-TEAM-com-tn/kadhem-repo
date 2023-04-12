import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_trainings/ui/views/error_view.dart';

import 'app_route_constants.dart';

import '../views/home_view.dart';
import '../views/trainings/add_training.dart';
import '../views/trainings/list_trainings.dart';
import '../views/categories/add_category.dart';
import '../views/categories/list_categories.dart';
import '../views/tags/add_tag.dart';
import '../views/tags/list_tags.dart';

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
          ),
          GoRoute(
            name: MyAppRouteConstants.addCategoryRouteName,
            path: '/addCategory',
            pageBuilder: (context, state) {
              return const MaterialPage(child: AddCategory());
            },
          ),
          GoRoute(
            name: MyAppRouteConstants.listCategoriesRouteName,
            path: '/listCategories',
            pageBuilder: (context, state) {
              return const MaterialPage(child: ListCategories());
            },
          ),
          GoRoute(
            name: MyAppRouteConstants.addTagRouteName,
            path: '/addTag',
            pageBuilder: (context, state) {
              return const MaterialPage(child: AddTag());
            },
          ),
          GoRoute(
            name: MyAppRouteConstants.listTagsRouteName,
            path: '/listTags',
            pageBuilder: (context, state) {
              return const MaterialPage(child: ListTags());
            },
          )
        ],
        errorPageBuilder: (context, state) {
          return const MaterialPage(child: ErrorView());
        });
    return router;
  }
}
