// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/training_model.dart';
import '../../providers/training_crud_model.dart';
import '../Pages/trainings/list_trainings.dart';
import '../Pages/trainings/modify_training.dart';


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
                child: Image.network(training.image, fit: BoxFit.cover)),
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
            },
            child: const Text("Open/Edit"),
          ),
          TextButton(
            onPressed: () async {
              await trainingProvider.removeTraining(training.id!);

                  Navigator.of(context).push(MaterialPageRoute(builder : (context) => const ListTrainings()));
            },
            child: const Text("Delete"),
          )
        ])
      ]),
    );
  }
}
