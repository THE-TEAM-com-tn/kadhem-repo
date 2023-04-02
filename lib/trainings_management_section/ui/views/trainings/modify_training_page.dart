// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:team_elearny/flutter_utils/ff_theme.dart';
import 'package:team_elearny/flutter_utils/ff_util.dart';
import 'package:team_elearny/flutter_utils/ff_widgets.dart';
import 'package:team_elearny/trainings_management_section/ui/shared/input_widget.dart';
import 'package:team_elearny/trainings_management_section/ui/views/trainings/training_page_model.dart';
import '../../../core/models/training_model.dart';
import '../../../core/viewmodels/training_crud_model.dart';
import '../../../ui/widgets/multi_select_tool.dart';
import 'package:team_elearny/trainings_management_section/ui/widgets/multi_select_tags_tool.dart';

class ModifyTraining extends StatefulWidget {
  final Training training;

  const ModifyTraining({super.key, required this.training});

  @override
  ModifyTrainingState createState() => ModifyTrainingState();
}

class ModifyTrainingState extends State<ModifyTraining> {
  late TrainingPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TrainingPageModel());
    _model.trainingTitleController ??= TextEditingController();
    _model.trainingDescriptionController ??= TextEditingController();
    _model.trainingAuthorController ??= TextEditingController();
    _model.trainingDurationController ??= TextEditingController();
    _model.trainingPriceController ??= TextEditingController();
    _model.trainingTrailerVidController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  List<String> _selectedCategories = [];
  List<String> _selectedTags = [];
  String imageUrl = "";

  void _showMultiSelect() async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MultiSelect();
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedCategories = results;
      });
    }
  }

  void _showMultiSelect_() async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MultiSelectTags();
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedTags = results;
      });
    }
    print("##### $_selectedTags");
  }

  void _selectImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (!kIsWeb) {
      print("##### Mobile Detetcted!");

      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      print("##### Image unique name: $uniqueFileName");

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImg = referenceRoot.child("images");
      Reference referenceImgToUpload = referenceDirImg.child(uniqueFileName);

      try {
        await referenceImgToUpload.putFile(File(file!.path));
        imageUrl = await referenceImgToUpload.getDownloadURL();
        print("##### Image URL: $imageUrl");
      } catch (error) {
        print("#####ERROR: $error");
      }
    } else if (kIsWeb) {
      print("##### Web Detetcted!");

      var imageBytes = await file?.readAsBytes();

      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      print("##### Image unique name: $uniqueFileName");

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImg = referenceRoot.child("images");
      Reference referenceImgToUpload = referenceDirImg.child(uniqueFileName);

      try {
        await referenceImgToUpload.putData(imageBytes!);
        imageUrl = await referenceImgToUpload.getDownloadURL();
        print("##### Image URL: $imageUrl");
      } catch (error) {
        print("#####ERROR: $error");
      }
    }
  }

  void handleSubmit(TrainingCRUDModel trainingProvider) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await trainingProvider.updateTraining(
          Training(
              title: _model.trainingTitleController.text,
              description: _model.trainingDescriptionController.text,
              category: _selectedCategories,
              author: _model.trainingAuthorController.text,
              duration: _model.trainingDurationController.text,
              price: double.parse(_model.trainingPriceController.text),
              trailerVid: _model.trainingTrailerVidController.text,
              image: imageUrl,
              tags: _selectedTags,
              creationDate: Timestamp.now()),
          widget.training.id!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final trainingProvider = Provider.of<TrainingCRUDModel>(context);

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Center(
            child: Text('Modify Training Details'),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  InputWidget(
                      initialValue: widget.training.title,
                      model: _model.trainingTitleController,
                      validator: _model.trainingTitleValidator,
                      text: '001', // ### Title ###
                      obscureText: false),
                  const SizedBox(
                    height: 16,
                  ),
                  InputWidget(
                      initialValue: widget.training.description,
                      model: _model.trainingDescriptionController,
                      validator: _model.trainingDescriptionValidator,
                      text: '002', // ### Description ###
                      obscureText: false),
                  const SizedBox(
                    height: 16,
                  ),
                  FFButtonWidget(
                      onPressed: _showMultiSelect,
                      text: FFLocalizations.of(context).getText(
                        '003' /* Select Catgeory */,
                      ),
                      options: FFButtonOptions(
                        width: 130.0,
                        height: 40.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FFTheme.of(context).primaryBackground,
                        textStyle: FFTheme.of(context).bodyText1.override(
                              fontFamily: 'Lexend Deca',
                              color: FFTheme.of(context).primaryColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FFTheme.of(context).bodyText1Family),
                            ),
                        elevation: 1.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                      )),
                  Wrap(
                    children: _selectedCategories
                        .map((e) => Chip(label: Text(e)))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InputWidget(
                      initialValue: widget.training.author,
                      model: _model.trainingAuthorController,
                      validator: _model.trainingAuthorValidator,
                      text: '004', // ### Author ###
                      obscureText: false),
                  const SizedBox(
                    height: 16,
                  ),
                  InputWidget(
                      initialValue: widget.training.duration,
                      model: _model.trainingDurationController,
                      validator: _model.trainingDurationValidator,
                      text: '005', // ### Duration ###
                      obscureText: false),
                  const SizedBox(
                    height: 16,
                  ),
                  InputWidget(
                      initialValue: widget.training.price.toString(),
                      model: _model.trainingPriceController,
                      validator: _model.trainingPriceValidator,
                      text: '006', // ### Price ###
                      obscureText: false),
                  const SizedBox(
                    height: 16,
                  ),
                  InputWidget(
                      initialValue: widget.training.trailerVid,
                      model: _model.trainingTrailerVidController,
                      text: '007', // ### Trailer ###
                      obscureText: false),
                  const SizedBox(
                    height: 16,
                  ),
                  FFButtonWidget(
                      onPressed: _selectImage,
                      text: FFLocalizations.of(context).getText(
                        '010' /* Select Image */,
                      ),
                      options: FFButtonOptions(
                        width: 130.0,
                        height: 40.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FFTheme.of(context).primaryBackground,
                        textStyle: FFTheme.of(context).bodyText1.override(
                              fontFamily: 'Lexend Deca',
                              color: FFTheme.of(context).primaryColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FFTheme.of(context).bodyText1Family),
                            ),
                        elevation: 1.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  FFButtonWidget(
                      onPressed: () async {
                        _showMultiSelect_();
                      },
                      text: FFLocalizations.of(context).getText(
                        '011' /* Select Tags */,
                      ),
                      options: FFButtonOptions(
                        width: 130.0,
                        height: 40.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FFTheme.of(context).primaryBackground,
                        textStyle: FFTheme.of(context).bodyText1.override(
                              fontFamily: 'Lexend Deca',
                              color: FFTheme.of(context).primaryColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FFTheme.of(context).bodyText1Family),
                            ),
                        elevation: 1.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                      )),
                  Wrap(
                    children:
                        _selectedTags.map((e) => Chip(label: Text(e))).toList(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FFButtonWidget(
                      onPressed: () async {
                        handleSubmit(trainingProvider);
                      },
                      text: FFLocalizations.of(context).getText(
                        '021' /* Update */,
                      ),
                      options: FFButtonOptions(
                        width: 130.0,
                        height: 40.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FFTheme.of(context).primaryBackground,
                        textStyle: FFTheme.of(context).bodyText1.override(
                              fontFamily: 'Lexend Deca',
                              color: FFTheme.of(context).primaryColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FFTheme.of(context).bodyText1Family),
                            ),
                        elevation: 1.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
