import 'package:flutter/material.dart';
import 'package:theteam_gyp/admin-interface/trainings/components/training_add_pop.dart';
import 'package:theteam_gyp/admin-interface/trainings/trainings_controller.dart';
import 'package:theteam_gyp/core/models/training_model.dart';
import 'package:theteam_gyp/user-interface/constans/mycolors.dart';
import 'package:theteam_gyp/admin-interface/trainings/widgets/admin_training_card.dart';

class AdminListTrainings extends StatelessWidget {
  AdminListTrainings({super.key});

  late List<TrainingModel> trainings;

  TrainingsController controller = TrainingsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: MyColors.primaryBackground,
        iconTheme: const IconThemeData(color: Color(0xFF101213)),
        automaticallyImplyLeading: true,
        title: const Text(
          'Admin - Trainings List',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: IconButton(
              icon: const Icon(
                Icons.library_add_rounded,
                color: MyColors.primary,
                size: 24,
              ),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TrainingAddPop();
                    });
              },
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      autofocus: true,
                      autofillHints: [AutofillHints.email],
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: MyColors.primaryBackground,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: MyColors.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: MyColors.alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: MyColors.alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        filled: true,
                        fillColor: MyColors.secondaryBackground,
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(24, 24, 0, 24),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: MyColors.secondaryText,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: controller.getAvailableTraining(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                trainings = snapshot.data!;
                return ListView.builder(
                  itemCount: trainings.length,
                  itemBuilder: (buildContext, index) =>
                      AdminTrainingCard(training: trainings[index]),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ]),
    );
  }
}
