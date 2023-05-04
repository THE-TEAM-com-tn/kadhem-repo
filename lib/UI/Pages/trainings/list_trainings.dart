import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearning_provider/UI/Pages/trainings/add_training.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/training_model.dart';
import '../../../providers/training_crud_model.dart';
import '../../Widgets/nav_bar.dart';
import '../../Widgets/training_card.dart';

class ListTrainings extends StatefulWidget {
  const ListTrainings({super.key});

  @override
  ListTrainingsState createState() => ListTrainingsState();
}

class ListTrainingsState extends State<ListTrainings> {
   List<Training> trainings = [];
  

  @override
  Widget build(BuildContext context) {
    final trainingProvider = Provider.of<TrainingCRUDModel>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddTraining()));
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<TrainingCRUDModel>(builder:(context, value, child) {
        
        if (value.loadingTraining)
        {value.getAllTraining(); }
        return !value.loadingTraining ? ListView.builder(
                itemCount: value.allTrainings.length,
                itemBuilder: (buildContext, index) =>
                    TrainingCard(training: value.allTrainings[index]),
              ) : CircularProgressIndicator();
      }, )
    );
  }
  
}


/* StreamBuilder(
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
            } else if (snapshot.connectionState != ConnectionState.active) {
              trainingProvider.fetchTrainingsAsStream() ;
              return  Text(snapshot.connectionState.name);
            } else {
              return Text('fetching');
            }
          }),*/