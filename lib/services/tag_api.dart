import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:elearning_provider/models/tag_model.dart';

class TagAPI {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  late CollectionReference ref;

  TagAPI(this.path) {
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

   getAllTags() async {
    List<Tag> tags = [];
    final data = await _db.collection('categories').get();
    for (var element in data.docs) {
      tags.add(Tag.fromJson(element.data(), element.id));
    }
    return tags ; 
  }
}
