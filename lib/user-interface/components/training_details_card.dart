import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theteam_gyp/user-interface/constans/assets_path.dart';
import 'package:theteam_gyp/user-interface/screens/login_screen.dart';
import '../../core/models/training_model.dart';
import '../constans/app_constants.dart';

class TrainingDetailsCard extends StatelessWidget {
  const TrainingDetailsCard({
    required this.data,
    // required this.onPressedAdd,
    Key? key,
    required this.isLogged,
  }) : super(key: key);

  final TrainingModel data;
  final bool isLogged;
  // final Function() onPressedAdd;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(kBorderRadius),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Transform.translate(
                offset: const Offset(10, 30),
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: SvgPicture.asset(
                    ImageVectorPath.happy2,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: kSpacing,
              top: kSpacing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  data.categories.join(" - "),
                ),
                const SizedBox(height: kSpacing),
                ElevatedButton(
                  onPressed: () async {
                    if (isLogged) {
                      // Get a reference to the profiles collection
                      CollectionReference profiles =
                          FirebaseFirestore.instance.collection('profiles');

                      // Update the document based on the provided ID
                      DocumentReference documentRef =
                          profiles.doc("JGCRmxK2Jy3mEruvktsr");

                      // Retrieve the existing document snapshot
                      DocumentSnapshot snapshot = await documentRef.get();

                      if (snapshot.exists) {
                        // Get the current values of totalPrice and trainings from the snapshot
                        double currentTotalPrice =
                            snapshot.get('inBasket.totalPrice');
                        List<dynamic> currentTrainings =
                            snapshot.get('inBasket.trainings');

                        // Update the totalPrice and trainings array with the new values
                        double updatedTotalPrice =
                            currentTotalPrice + data.price;
                        List<dynamic> updatedTrainings =
                            List.from(currentTrainings)..add(data.id);

                        // Update the document with the new values
                        await documentRef.update({
                          'inBasket.totalPrice': updatedTotalPrice,
                          'inBasket.trainings': updatedTrainings,
                        });
                      }
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }
                  },
                  child: const Text("Add To Cart"),
                ),
                const SizedBox(height: kSpacing * 2),
                Text(
                  "Description: ${data.description}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: kSpacing),
                Text(
                  "Author: ${data.author}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: kSpacing),
                Text(
                  "Duration: ${data.duration}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: kSpacing),
                Text(
                  "Price: ${data.price}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: kSpacing),
                Text(
                  "Introduction: ${data.trailerVid}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: kSpacing),
                Text(
                  "Created in: ${data.creationDate}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: kSpacing),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
