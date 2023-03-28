// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider_trainings/core/models/training_model.dart';
import 'package:provider_trainings/core/viewmodels/training_crud_model.dart';
import 'package:provider_trainings/ui/router/app_route_constants.dart';
import 'package:provider_trainings/ui/views/modify_training.dart';

class TrainingCard extends StatelessWidget {
  final Training training;
  const TrainingCard({Key? key, required this.training}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trainingProvider = Provider.of<TrainingCRUDModel>(context);

    return Card(
      color: Colors.white,
      child: Column(children: <Widget>[
        SizedBox(
          height: 180.0,
          child: Stack(children: <Widget>[
            Positioned.fill(
                child: Image.asset("card-cover.avif", fit: BoxFit.cover)),
            Positioned(
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(training.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.white))))
          ]),
        ),
        ButtonBar(alignment: MainAxisAlignment.end, children: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ModifyTraining(training: training)));
              print("Title: ${training.title}");
              print("Title: ${training.category}");
              print("Title: ${training.tags}");
            },
            child: const Text("Open/Edit"),
          ),
          TextButton(
            onPressed: () async {
              await trainingProvider.removeTraining(training.id!);
              GoRouter.of(context)
                  .pushNamed(MyAppRouteConstants.listTrainingsRouteName);
            },
            child: const Text("Delete"),
          )
        ])
      ]),
    );
  }
}
