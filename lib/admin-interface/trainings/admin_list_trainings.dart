import 'package:flutter/material.dart';
import 'package:theteam_gyp/core/models/training_model.dart';
import 'package:theteam_gyp/user-interface/constans/mycolors.dart';

class AdminListTrainings extends StatelessWidget {
  AdminListTrainings({super.key});

  late List<TrainingModel> trainings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: MyColors.primaryBackground,
        iconTheme: const IconThemeData(color: Color(0xFF101213)),
        automaticallyImplyLeading: true,
        title: const Text(
          'Admin - Trainings List ',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: IconButton(
              /*   borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 44,*/
              icon: const Icon(
                Icons.library_add_rounded,
                color: MyColors.primary,
                size: 24,
              ),
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => const AddTraining()),
                // );
                // print('AddTraining_IconButton pressed ...');
              },
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(builder: (context) => const AddTraining()),
          // );
        },
        child: const Icon(Icons.add),
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
                  child: Container(
                    width: double.infinity,
                    child: TextFormField(
                      // controller: _model.searchFieldsController,
                      autofocus: true,
                      autofillHints: [AutofillHints.email],
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Search for your training...',
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
                      //keyboardType: TextInputType.emailAddress,
                      /*validator:
                  _model.searchFieldsControllerValidator.asValidator(context),*/
                    ),
                  ),
                ),
              ),

              // TEXT TITLE :
            ],
          ),
        ),

/*        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Text(
                  'Trainings List',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),*/

        // Expanded(
        //   child: StreamBuilder(

        //         stream: trainingProvider.fetchTrainingsAsStream(),
        //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //           if (snapshot.hasData) {
        //             trainings = snapshot.data!.docs
        //                 .map((doc) =>
        //                 Training.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        //                 .toList();
        //             return ListView.builder(
        //               itemCount: trainings.length,
        //               itemBuilder: (buildContext, index) =>
        //                   AdminTrainingCard(training: trainings[index]),
        //             );
        //           } else {
        //             return const Text('fetching');
        //           }
        //         },
        //       ),
        // ),
      ]),
    );
  }
}

/*
          // SEARCH BAR :

          // Generated code for this searchRow Widget...
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 6, 16, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                       // controller: _model.searchFieldsController,
                        autofocus: true,
                        autofillHints: [AutofillHints.email],
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Search for your getaway...',
                          //labelStyle: FFTheme.of(context).labelLarge,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.primaryBackground,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.primary,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.alternate,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.alternate,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          filled: true,
                          fillColor: MyColors.secondaryBackground,
                          contentPadding: EdgeInsetsDirectional.fromSTEB(24, 24, 0, 24),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: MyColors.secondaryText,
                            size: 24,
                          ),
                        ),
                        //style: FFTheme.of(context).bodyLarge,
                        keyboardType: TextInputType.emailAddress,
                        /*validator:
                        _model.searchFieldsControllerValidator.asValidator(context),*/
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),



          // TEXT TITLE :
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                 Text(
                  'Trainings List',
                 // style: FFTheme.of(context).labelMedium,
                ),
              ],
            ),
          ),

*/