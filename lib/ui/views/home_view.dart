import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_trainings/ui/router/app_route_constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context)
                    .pushNamed(MyAppRouteConstants.listTrainingsRouteName);
              },
              child: const Text('Trainings'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context)
                    .pushNamed(MyAppRouteConstants.listCategoriesRouteName);
              },
              child: const Text('Categories'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context)
                    .pushNamed(MyAppRouteConstants.listTagsRouteName);
              },
              child: const Text('Tags'),
            ),
          ],
        ),
      ),
    );
  }
}
