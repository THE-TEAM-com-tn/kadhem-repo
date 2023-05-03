import 'package:elearning_provider/providers/training_crud_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../models/training_model.dart';
import 'InputWidget.dart';

class AssignTrainingPopup extends StatefulWidget {
  const AssignTrainingPopup({super.key, required this.uid});
  final String uid;
  @override
  State<AssignTrainingPopup> createState() => _AssignTrainingPopupState();
}

class _AssignTrainingPopupState extends State<AssignTrainingPopup> {
  List<bool> isChecked = [];
  bool filter =false; 
  List<Training> toAdd = [];
  List<Training> searchedTrainings = [];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 2,
          child: Consumer<TrainingCRUDModel>(builder: (context, value, child) {
            if (value.loadingTraining) {
              value.getTrainings(widget.uid);
              isChecked = [];
              filter = false ; 
            } else if (!value.loadingTraining && !filter){
              searchedTrainings = value.allTrainings;
            }
            return !value.loadingTraining
                ? Column(children: [
                    Text("List of Trainings"),
                    InputWidget(
                      obcure: false,
                      text: 'Search Trainings by name',
                      initialValue: '',
                      enabled: true,
                      maxLines: 1,
                      onChanged: (query) {
                        setState(() {
                          filterData(query, value.allTrainings);
                        });
                      },
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        searchedTrainings
                            .forEach((element) => isChecked.add(false));
                        return Column(children: [
                          Card(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: isChecked[index],
                                      onChanged: (val) {
                                        setState(() {
                                          if (val == true) {
                                            toAdd.add(searchedTrainings[index]);
                                          } else {
                                            toAdd.remove(
                                                searchedTrainings[index]);
                                          }
                                          isChecked[index] = val!;
                                        });
                                      }),
                                  Image.network(
                                    searchedTrainings[index].image,
                                    height: 100,
                                    width: 100,
                                  ),
                                  Text(searchedTrainings[index].title)
                                ],
                              ),
                            ),
                          ),
                        ]);
                      },
                      itemCount: searchedTrainings.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await value.assignTrainingToUser(toAdd, widget.uid);
                          setState(() {
                            value.loadingTraining = true;
                          });
                        },
                        child: Text('save')),
                    ElevatedButton(
                        onPressed: () {
                          value.loadingTraining = true;
                          Navigator.pop(context);
                        },
                        child: Text('cancel')),
                  ])
                : CircularProgressIndicator();
          }),
        ),
      ),
    );
  }

  filterData(String value, List<Training> trainings) {
    searchedTrainings = [];
    setState(() {
          searchedTrainings = trainings
        .where((item) => item.title.toLowerCase().contains(value.toLowerCase()))
        .toList();
        filter = true;
    });

  }
}
