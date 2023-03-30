import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_elearny/flutter_utils/ff_util.dart';
import 'package:team_elearny/trainings_management_section/locator.dart';
import 'package:team_elearny/trainings_management_section/core/viewmodels/training_crud_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<TrainingCRUDModel>())
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.pushNamed("ListTrainings");
                },
                child: const Text('Trainings'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed('ListCategories');
                },
                child: const Text('Categories'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed('ListTags');
                },
                child: const Text('Tags'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
