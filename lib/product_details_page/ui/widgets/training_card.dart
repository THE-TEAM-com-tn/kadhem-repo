// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/training_model.dart';
import '../../core/viewmodels/training_crud_model.dart';
import '../../ui/views/modify_training.dart';

class TrainingCard extends StatelessWidget {
  final Training training;
  const TrainingCard({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    final trainingProvider = Provider.of<TrainingCRUDModel>(context);

    // Timestamp? timestamp = training.creationDate;
    // DateTime dateTime = timestamp!.toDate();
    // String formattedDateTime = DateFormat.yMMMEd().format(dateTime);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ModifyTraining(training: training))
        );
      },
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
              child: Column(children: [
            AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await trainingProvider.removeTraining(training.id!);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            ListTile(
              title: Text("Title: ${training.title}"),
              subtitle: Container(
                child: (Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Text("Category: ${training.category.join(" - ")}", style: const TextStyle(fontSize: 14)),
                    Text("Author: ${training.author}", style: const TextStyle(fontSize: 14)),
                    Text("Description: ${training.description}",  style: const TextStyle(fontSize: 14)),
                    Text("Duration: ${training.duration}", style: const TextStyle(fontSize: 14)),
                    Text("Price: ${training.price.toString()}", style: const TextStyle(fontSize: 14)),
                    Text("Trailer Video: ${training.trailerVid}", style: const TextStyle(fontSize: 14)),
                    // Text("Tags: ${training.tags!.join(" - ")}", style: const TextStyle(fontSize: 14)),
                    Image.network(training.image, width: 50, height: 50),
                    Text("Creation date: ${training.creationDate}", style: const TextStyle(fontSize: 14))
                  ],
                )),
              ),
            ),
          ]))),
    );
  }
}
