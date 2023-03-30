// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/models/training_model.dart';
import '../../core/viewmodels/training_crud_model.dart';
import '../views/trainings/modify_training_page.dart';

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
            },
            child: const Text("Open/Edit"),
          ),
          TextButton(
            onPressed: () async {
              await trainingProvider.removeTraining(training.id!);
              // Navigator.pop(context);
            },
            child: const Text("Delete"),
          )
        ])
      ]),
    );
  }
}
