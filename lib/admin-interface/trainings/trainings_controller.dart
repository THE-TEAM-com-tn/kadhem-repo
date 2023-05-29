import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:theteam_gyp/admin-interface/models/category_model.dart';
import 'package:theteam_gyp/admin-interface/models/tag_model.dart';
import 'package:theteam_gyp/core/models/training_model.dart';

class TrainingsController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateTraining(
      Map<String, dynamic> updatedData, String trainingId) async {
    try {
      final DocumentReference trainingRef =
          FirebaseFirestore.instance.collection('trainings').doc(trainingId);

      await trainingRef.update(updatedData);
    } catch (error) {
      print(
          '##### ERROR ::: training_controller => updateTtraining() ::: $error');
    }
  }

  // Delete doc by ID
  Future<void> deleteDocumentById(
      String collectionName, String documentId) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection(collectionName);
      await collection.doc(documentId).delete();
      print('Document deleted: $documentId');
    } catch (error) {
      print('Error deleting document: $error');
    }
  }

  // Get all available trainings
  Stream<List<TrainingModel>> getAvailableTraining() {
    return _firestore.collection('trainings').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final docData = doc.data();
        return TrainingModel(
          id: doc.id,
          title: docData['title'],
          description: docData['description'],
          categories: List<String>.from(docData['categories']),
          author: docData['author'],
          duration: docData['duration'],
          price: docData['price'],
          trailerVid: docData['trailerVid'],
          image: docData['image'],
          tags: List<String>.from(docData['tags']),
          creationDate: docData['creationDate'],
        );
      }).toList();
    });
  }

  // Get all available trainings in DB
  Future<List<TagModel>> getAvailableTags() async {
    final snapshot = await _firestore.collection('tags').get();
    final data = snapshot.docs.map((doc) {
      final docData = doc.data();
      return TagModel(
          id: doc.id, label: docData['label'], color: docData['color']);
    }).toList();
    return data;
  }

  // Get all available categories in DB
  Future<List<CategoryModel>> getAvailableCategories() async {
    final snapshot = await _firestore.collection('categories').get();
    final data = snapshot.docs.map((doc) {
      final docData = doc.data();
      return CategoryModel(
          id: doc.id,
          name: docData['name'],
          description: docData['description']);
    }).toList();
    return data;
  }

  // Get category by ID
  Future<List<CategoryModel>> getCategoryById() async {
    final snapshot = await _firestore.collection('categories').get();
    final data = snapshot.docs.map((doc) {
      final docData = doc.data();
      return CategoryModel(
          id: doc.id,
          name: docData['name'],
          description: docData['description']);
    }).toList();
    return data;
  }

  Future<void> addDocToCol(Map<String, dynamic> data, String col) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection(col);
      await collection.add(data);
    } catch (error) {
      print('##### ERROR ::: trainings_controller => addDocToCol() ::: $error');
    }
  }

  void addTraining(TrainingModel training) async {}
}
