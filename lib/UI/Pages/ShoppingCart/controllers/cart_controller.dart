import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearning_provider/models/training_model.dart';

class CartController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> getProfile() {
    // Get a reference to the profiles collection
    CollectionReference profiles = _firestore.collection('Users');

    // Retrieve the profile document
    Stream<QuerySnapshot> snapshot = profiles.snapshots();

    return snapshot;
  }

  Future<List<Training>> getTrainingsListById(trainingsIDs) async {
    print(
        "##### cart_controller.dart => _getTrainingsListById() ::: $trainingsIDs");

    List<Training> trainingModels = [];

    // Access the "training" collection in Firestore
    QuerySnapshot querySnapshot = await _firestore
        .collection('trainings')
        .where(FieldPath.documentId, whereIn: trainingsIDs)
        .get();

    // Iterate over the query snapshot to create TrainingModel objects
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      Training trainingModel = Training(
        id: documentSnapshot.id,
        title: data['title'],
        description: data['description'],
        category: List<String>.from(data['categories']),
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

  // List<dynamic> _getCartData() {
  //   final List<String> trainings = arguments["trainings"];
  //   final double totalPrice = arguments["totalPrice"];
  //   return [trainings, totalPrice];
  // }

  // TrainingModel _getTrainingDetails() {
  //   final TrainingModel training = (arguments == null)
  //       ? TrainingModel(
  //           id: "id",
  //           title: "title",
  //           description: "description",
  //           categories: ["categories"],
  //           author: "author",
  //           duration: "duration",
  //           price: 0.0,
  //           trailerVid: "trailerVid",
  //           image: "image",
  //           creationDate: Timestamp(100, 999))
  //       : arguments['trainingData'];
  //   return training;
  // }

  // ProjectCardData getSelectedProject() {
  //   return ProjectCardData(
  //     percent: .3,
  //     projectImage: const AssetImage(ImageRasterPath.logo1),
  //     projectName: "Marketplace Mobile",
  //     releaseTime: DateTime.now(),
  //   );
  // }

  // List<ProjectCardData> getActiveProject() {
  //   return [
  //     ProjectCardData(
  //       percent: .3,
  //       projectImage: const AssetImage(ImageRasterPath.logo2),
  //       projectName: "Taxi Online",
  //       releaseTime: DateTime.now().add(const Duration(days: 130)),
  //     ),
  //     ProjectCardData(
  //       percent: .5,
  //       projectImage: const AssetImage(ImageRasterPath.logo3),
  //       projectName: "E-Movies Mobile",
  //       releaseTime: DateTime.now().add(const Duration(days: 140)),
  //     ),
  //     ProjectCardData(
  //       percent: .8,
  //       projectImage: const AssetImage(ImageRasterPath.logo4),
  //       projectName: "Video Converter App",
  //       releaseTime: DateTime.now().add(const Duration(days: 100)),
  //     ),
  //   ];
  // }

  // List<ImageProvider> getMember() {
  //   return const [
  //     AssetImage(ImageRasterPath.avatar1),
  //     AssetImage(ImageRasterPath.avatar2),
  //     AssetImage(ImageRasterPath.avatar3),
  //     AssetImage(ImageRasterPath.avatar4),
  //     AssetImage(ImageRasterPath.avatar5),
  //     AssetImage(ImageRasterPath.avatar6),
  //   ];
  // }

  // List<ChattingCardData> getChatting() {
  //   return const [
  //     ChattingCardData(
  //       image: AssetImage(ImageRasterPath.avatar6),
  //       isOnline: true,
  //       name: "Samantha",
  //       lastMessage: "i added my new tasks",
  //       isRead: false,
  //       totalUnread: 100,
  //     ),
  //     ChattingCardData(
  //       image: AssetImage(ImageRasterPath.avatar3),
  //       isOnline: false,
  //       name: "John",
  //       lastMessage: "well done john",
  //       isRead: true,
  //       totalUnread: 0,
  //     ),
  //     ChattingCardData(
  //       image: AssetImage(ImageRasterPath.avatar4),
  //       isOnline: true,
  //       name: "Alexander Purwoto",
  //       lastMessage: "we'll have a meeting at 9AM",
  //       isRead: false,
  //       totalUnread: 1,
  //     ),
  //   ];
  // }
}
