import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_trainings/core/models/training_model.dart';
import 'package:provider_trainings/core/viewmodels/training_crud_model.dart';
import 'package:provider_trainings/ui/router/app_route_constants.dart';
import 'package:provider_trainings/ui/widgets/training_card.dart';
import 'package:provider/provider.dart';

class ListTrainings extends StatefulWidget {
  const ListTrainings({super.key});

  @override
  ListTrainingsState createState() => ListTrainingsState();
}

class ListTrainingsState extends State<ListTrainings> {
  late List<Training> trainings;

  @override
  Widget build(BuildContext context) {
    final trainingProvider = Provider.of<TrainingCRUDModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context)
              .pushNamed(MyAppRouteConstants.addTrainingRouteName);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Trainings Management"),
      ),
      body: StreamBuilder(
          stream: trainingProvider.fetchTrainingsAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              trainings = snapshot.data!.docs
                  .map((doc) => Training.fromJson(
                      doc.data() as Map<String, dynamic>, doc.id))
                  .toList();
              return ListView.builder(
                itemCount: trainings.length,
                itemBuilder: (buildContext, index) =>
                    TrainingCard(training: trainings[index]),
              );
            } else {
              return const Text('fetching');
            }
          }),
    );
  }
}
