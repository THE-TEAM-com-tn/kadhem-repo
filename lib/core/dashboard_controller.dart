import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:theteam_gyp/core/models/profile_model.dart';
import 'package:theteam_gyp/core/models/training_model.dart';
import 'package:theteam_gyp/user-interface/components/chatting_card.dart';
import 'package:theteam_gyp/user-interface/components/project_card.dart';
import 'package:theteam_gyp/user-interface/components/task_card.dart';
import 'package:theteam_gyp/user-interface/constans/assets_path.dart';
import 'package:theteam_gyp/user-interface/utils/training_category.dart';

class DashboardController {
  // Create a StreamController
  StreamController<String> streamController = StreamController<String>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get user by id
  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserById() async {
    try {
      // Get the current user
      User? user = _auth.currentUser;
      String? userId = user!.uid;

      try {
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(userId)
                .get();
        return userSnapshot;
      } catch (error) {
        print('Error retrieving user: $error');
        return null;
      }
    } catch (error) {
      print('Error retrieving user credentials: $error');
      return null;
    }
  }

  // Get list of trainings by a list of IDs
  late String? uid;
  late dynamic totalPrice = 0;

  void getUserID() async {
    uid = _auth.currentUser!.uid;
  }

  // Get trainings that their IDs are in basket in user's entity ##### FUNCTION
  Future<List<TrainingModel>> getTraineesBasket() async {
    // Get loggedin user's id
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    // Get loggedin trainee's doc
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('trainees').doc(uid).get();

    Map<String, dynamic>? data = snapshot.data();

    Map<String, dynamic> basket = data!['inBasket'];
    totalPrice = basket['totalPrice'];

    List<dynamic> trainingsIDs = basket['trainings'];
    print("##### LOG ::: controller ::: getTraineesBasket ::: $trainingsIDs");

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

  // See if there is a user logged in or not ##### FUNCTION
  Future<bool> isLoggedIn() async {
    final User? user = _auth.currentUser;
    return user != null;
  }

  // Get all available trainings in DB ##### FUNCTION
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
    CollectionReference profiles = _firestore.collection('trainees');

    // Retrieve the profile document
    Stream<QuerySnapshot> snapshot = profiles.snapshots();

    return snapshot;
  }

  // Get user's details from DB ##### FUNCTION
  Future<ProfileModel> getUserDetails() async {
    final userid = _auth.currentUser!.uid;
    final snapshot = await _firestore.collection('trainees').doc(userid).get();
    final userdata = snapshot.data();
    final phone = userdata!['phone'];
    final company = userdata!['company'];
    final address = userdata!['address'];
    final bio = userdata!['bio'];
    final name = userdata!['name'];
    final email = userdata!['email'];
    final photo = userdata!['photo'];
    return ProfileModel(
        phone: phone,
        company: company,
        address: address,
        bio: bio,
        name: name,
        email: email,
        photo: photo);
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
