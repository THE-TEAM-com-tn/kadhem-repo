// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import '../../locator.dart';
import '../services/training_api.dart';
import '../models/training_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingCRUDModel extends ChangeNotifier {
  final TrainingAPI _api = locator<TrainingAPI>();
  bool loadingTraining = true  ;
  late List<Training> trainings;
  List<Training> allTrainings = [] ;
  List<Training> userTrainings = [] ;
  // Future<List<Training>> fetchTrainings() async {
  //   var result = await _api.getDataCollection();
  //   trainings = result.docs
  //   .map((doc) => Training.fromJson(doc.data as Map<String, dynamic>, doc.id))
  //   .toList();
  //   return trainings;
  // }


  Stream<QuerySnapshot<Object?>> fetchTrainingsAsStream() {
    return _api.streamDataCollection();
  }

  Future removeTraining(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateTraining(Training data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addTraining(Training data) async {
    var result = await _api.addDocument(data.toJson());
    return;
  }

  getAllTraining() async {
    allTrainings = await _api.getAllTraining();
    loadingTraining = false ; 
    notifyListeners();
  }

  getTrainings(String uid) async {
    allTrainings = await _api.getUnasignedTrainings(uid);
    loadingTraining = false ; 
    notifyListeners();
  }

  assignTrainingToUser(List<Training> trainings, String uid) async{
    await _api.assignTrainingToUser(trainings, uid);
  }

  getUserTrainings(String uid) async {
    userTrainings = await _api.getUserTrainings(uid);
    loadingTraining = false ; 
    notifyListeners();
  }

  deleteTrainingsToUser(List<Training> trainings, String uid) async {
    await _api.deleteTrainingFromUser(trainings, uid);
  }
}
