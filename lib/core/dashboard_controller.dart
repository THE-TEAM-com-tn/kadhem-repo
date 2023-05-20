import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:theteam_gyp/core/models/training_model.dart';
import 'package:theteam_gyp/user-interface/components/chatting_card.dart';
import 'package:theteam_gyp/user-interface/components/project_card.dart';
import 'package:theteam_gyp/user-interface/components/task_card.dart';
import 'package:theteam_gyp/user-interface/constans/assets_path.dart';
import 'package:theteam_gyp/user-interface/utils/training_category.dart';

class DashboardController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<TrainingModel>> getTrainingsListById(trainingsIDs) async {
    print(
        "##### cart_controller.dart => _getTrainingsListById() ::: $trainingsIDs");

    List<TrainingModel> trainingModels = [];

    // Access the "training" collection in Firestore
    QuerySnapshot querySnapshot = await _firestore
        .collection('trainings')
        .where(FieldPath.documentId, whereIn: trainingsIDs)
        .get();

    // Iterate over the query snapshot to create TrainingModel objects
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      TrainingModel trainingModel = TrainingModel(
        id: documentSnapshot.id,
        title: data['title'],
        description: data['description'],
        categories: List<String>.from(data['categories']),
        author: data['author'],
        duration: data['duration'],
        price: data['price'].toDouble(),
        trailerVid: data['trailerVid'],
        image: data['image'],
        tags: data['tags'] != [] ? List<String>.from(data['tags']) : [],
        creationDate: data['creationDate'],
      );

      trainingModels.add(trainingModel);
    }

    return trainingModels;
  }

  Future<bool> isLoggedIn() async {
    final User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<List<TrainingModel>> getTrainingsData() async {
    final snapshot = await _firestore.collection('trainings').get();
    final data = snapshot.docs.map((doc) {
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
    return data;
  }

  // Data
  Stream<QuerySnapshot<Object?>> getProfile() {
    // Get a reference to the profiles collection
    CollectionReference profiles = _firestore.collection('Users');

    // Retrieve the profile document
    Stream<QuerySnapshot> snapshot = profiles.snapshots();

    return snapshot;
  }

  // Get user by ID
  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserById(
      String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .get();
      if (userSnapshot.exists) {
        return userSnapshot;
      } else {
        print('User not found');
        return null;
      }
    } catch (error) {
      print('Error retrieving user: $error');
      return null;
    }
  }

  List<TaskCardData> getAllTask() {
    return [
      const TaskCardData(
        title: "Landing page UI Design",
        dueDay: 2,
        totalComments: 50,
        trainingCategory: TrainingCategory.agile,
        totalContributors: 30,
        profilContributors: [
          AssetImage(ImageRasterPath.avatar1),
          AssetImage(ImageRasterPath.avatar2),
          AssetImage(ImageRasterPath.avatar3),
          AssetImage(ImageRasterPath.avatar4),
        ],
      ),
      const TaskCardData(
        title: "Landing page UI Design",
        dueDay: -1,
        totalComments: 50,
        totalContributors: 34,
        trainingCategory: TrainingCategory.devOPS,
        profilContributors: [
          AssetImage(ImageRasterPath.avatar5),
          AssetImage(ImageRasterPath.avatar6),
          AssetImage(ImageRasterPath.avatar7),
          AssetImage(ImageRasterPath.avatar8),
        ],
      ),
      const TaskCardData(
        title: "Landing page UI Design",
        dueDay: 1,
        totalComments: 50,
        totalContributors: 34,
        trainingCategory: TrainingCategory.business,
        profilContributors: [
          AssetImage(ImageRasterPath.avatar5),
          AssetImage(ImageRasterPath.avatar3),
          AssetImage(ImageRasterPath.avatar4),
          AssetImage(ImageRasterPath.avatar2),
        ],
      ),
    ];
  }

  ProjectCardData getSelectedProject() {
    return ProjectCardData(
      percent: .3,
      projectImage: const AssetImage(ImageRasterPath.logo1),
      projectName: "Marketplace Mobile",
      releaseTime: DateTime.now(),
    );
  }

  List<ProjectCardData> getActiveProject() {
    return [
      ProjectCardData(
        percent: .3,
        projectImage: const AssetImage(ImageRasterPath.logo2),
        projectName: "Taxi Online",
        releaseTime: DateTime.now().add(const Duration(days: 130)),
      ),
      ProjectCardData(
        percent: .5,
        projectImage: const AssetImage(ImageRasterPath.logo3),
        projectName: "E-Movies Mobile",
        releaseTime: DateTime.now().add(const Duration(days: 140)),
      ),
      ProjectCardData(
        percent: .8,
        projectImage: const AssetImage(ImageRasterPath.logo4),
        projectName: "Video Converter App",
        releaseTime: DateTime.now().add(const Duration(days: 100)),
      ),
    ];
  }

  List<ImageProvider> getMember() {
    return const [
      AssetImage(ImageRasterPath.avatar1),
      AssetImage(ImageRasterPath.avatar2),
      AssetImage(ImageRasterPath.avatar3),
      AssetImage(ImageRasterPath.avatar4),
      AssetImage(ImageRasterPath.avatar5),
      AssetImage(ImageRasterPath.avatar6),
    ];
  }

  List<ChattingCardData> getChatting() {
    return const [
      ChattingCardData(
        image: AssetImage(ImageRasterPath.avatar6),
        isOnline: true,
        name: "Samantha",
        lastMessage: "i added my new tasks",
        isRead: false,
        totalUnread: 100,
      ),
      ChattingCardData(
        image: AssetImage(ImageRasterPath.avatar3),
        isOnline: false,
        name: "John",
        lastMessage: "well done john",
        isRead: true,
        totalUnread: 0,
      ),
      ChattingCardData(
        image: AssetImage(ImageRasterPath.avatar4),
        isOnline: true,
        name: "Alexander Purwoto",
        lastMessage: "we'll have a meeting at 9AM",
        isRead: false,
        totalUnread: 1,
      ),
    ];
  }
}
