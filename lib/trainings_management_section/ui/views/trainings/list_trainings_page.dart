import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_elearny/flutter_utils/ff_util.dart';
import 'package:team_elearny/trainings_management_section/ui/shared/image_card_widget.dart';
import '../../../core/models/training_model.dart';
import '../../../core/viewmodels/training_crud_model.dart';
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
      appBar: AppBar(
        title: const Text("Trainings Management"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
            child: StreamBuilder(
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
                            ImageCardWidget(training: trainings[index]));
                  } else {
                    return const Text('fetching');
                  }
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed("AddTraining");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
