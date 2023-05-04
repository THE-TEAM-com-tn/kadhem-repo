import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:elearning_provider/models/category_model.dart';

class CategoryAPI {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  late CollectionReference ref;

  CategoryAPI(this.path) {
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

    getAllCategories() async {
    List<TrainingCategory> categories = [];
    final data = await _db.collection('categories').get();
    for (var element in data.docs) {
      categories.add(TrainingCategory.fromJson(element.data(), element.id));
    }
    return categories ; 
  }
}
