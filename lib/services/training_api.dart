import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:elearning_provider/models/training_model.dart';

class TrainingAPI {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  late CollectionReference ref;
  List<Training> trainings = [];
  TrainingAPI(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.doc(id).update(data as Map<Object, Object?>);
  }

  getUnasignedTrainings(String uid) async {
    trainings = [];
    final data = await _db.collection('trainings').get();
    for (var element in data.docs) {
      trainings.add(Training.fromJson(element.data(), element.id));
    }
    List<Training> userTrainings = [];
    final usersData =
        await _db.collection("Users").doc(uid).collection("trainings").get();

    for (var element in usersData.docs) {
      userTrainings.add(Training.fromJson(element.data(), element.id));
    }
    trainings.removeWhere((element1) => userTrainings.any((element2) => element1.id == element2.id ));
    return trainings;
  }

  assignTrainingToUser(List<Training> trainings, String uid) async {
    CollectionReference trainingsRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('trainings');
    QuerySnapshot trainingsSnapshot = await trainingsRef.get();
    if (trainingsSnapshot.size == 0) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('trainings')
          .add({});
    }
    trainings.forEach((element) async {
      await trainingsRef.doc(element.id).set(element.toJson());
    });
  }
}
