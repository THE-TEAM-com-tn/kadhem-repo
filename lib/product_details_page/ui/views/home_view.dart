import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_elearny/product_details_page/locator.dart';
import 'package:team_elearny/product_details_page/core/viewmodels/training_crud_model.dart';

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
                  Navigator.pushNamed(context, '/list_trainings');
                },
                child: const Text('Trainings'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/list_categories');
                },
                child: const Text('Categories'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/list_tags');
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
