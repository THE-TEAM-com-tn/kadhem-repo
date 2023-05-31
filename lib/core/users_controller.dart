import 'package:cloud_firestore/cloud_firestore.dart';

class UsersController {
  // Update user's data ##### FUNCTION
  Future<void> updateUser(
      Map<String, dynamic> updatedData, String userId) async {
    try {
      final DocumentReference userRef =
          FirebaseFirestore.instance.collection('trainees').doc(userId);

      await userRef.update(updatedData);
    } catch (error) {
      print('##### ERROR ::: users_controller => updateUser() ::: $error');
    }
  }
}
