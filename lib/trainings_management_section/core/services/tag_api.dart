import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

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
}
