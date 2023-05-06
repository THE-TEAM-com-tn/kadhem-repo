import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearning_provider/UI/Pages/trainings/add_training.dart';
import 'package:elearning_provider/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/training_model.dart';
import '../../../providers/training_crud_model.dart';
import '../../Widgets/nav_bar.dart';
import '../../Widgets/training_card.dart';

class UsersTrainings extends StatefulWidget {
  const UsersTrainings({super.key});

  @override
  UsersTrainingsState createState() => UsersTrainingsState();
}

class UsersTrainingsState extends State<UsersTrainings> {
   List<Training> trainings = [];
  

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.uid);
    final trainingProvider = Provider.of<TrainingCRUDModel>(context);
    return Scaffold(
      body: Consumer<TrainingCRUDModel>(builder:(context, value, child) {
        
        if (value.loadingUserTraining)
        {value.showUserTrainings(userModel.userId!, "userList"); }
        return !value.loadingUserTraining ? ListView.builder(
                itemCount: value.userTrainings.length,
                itemBuilder: (buildContext, index) =>
                    TrainingCard(training: value.userTrainings[index]),
              ) : CircularProgressIndicator();
      }, )
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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