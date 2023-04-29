import 'package:elearning_provider/providers/training_crud_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../models/training_model.dart';

class AssignTrainingPopup extends StatefulWidget {
  const AssignTrainingPopup({super.key, required this.uid});
  final String uid;
  @override
  State<AssignTrainingPopup> createState() => _AssignTrainingPopupState();
}

class _AssignTrainingPopupState extends State<AssignTrainingPopup> {
  List<bool> isChecked = [];
  List<Training> toAdd = [];
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
            }
            return !value.loadingTraining
                ? Column(children: [
                    ListView.builder(
                      itemBuilder: (context, index) {
                        value.allTrainings
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
                                            toAdd
                                                .add(value.allTrainings[index]);
                                          } else {
                                            toAdd.remove(
                                                value.allTrainings[index]);
                                          }
                                          isChecked[index] = val!;
                                        });
                                      }),
                                  Image.network(
                                    value.allTrainings[index].image,
                                    height: 100,
                                    width: 100,
                                  ),
                                  Text(value.allTrainings[index].title)
                                ],
                              ),
                            ),
                          ),
                        ]);
                      },
                      itemCount: value.allTrainings.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          value.assignTrainingToUser(toAdd, widget.uid);
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
}
