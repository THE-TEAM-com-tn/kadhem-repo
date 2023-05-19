import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ChangePasswordPageModel   {

  ///  State fields for stateful widgets in this page.
  bool isMediaUploading = false;
  // State field(s) for yourName widget.
  TextEditingController? oldPasswordController;
  // State field(s) for emailAddress widget.
  TextEditingController? newPasswordController;
  // State field(s) for myBio widget.
  TextEditingController? confirmPasswordController;

  String?  oldPasswordControllerValidator(String? value) {
    if (value!.isEmpty) {return 'this field is required' ;}
    return null ;
  }

  String?  newPasswordControllerValidator(String? value) {
      final upperCaseRegex = RegExp(r'[A-Z]');
  final lowerCaseRegex = RegExp(r'[a-z]');
  final numberRegex = RegExp(r'[0-9]');
  final symbolRegex = RegExp(r'[!@#\$&*~%]');

  if (value!.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  if (!upperCaseRegex.hasMatch(value)) {
    return 'Password must contain at least 1 uppercase letter';
  }
  if (!lowerCaseRegex.hasMatch(value)) {
    return 'Password must contain at least 1 lowercase letter';
  }
  if (!numberRegex.hasMatch(value)) {
    return 'Password must contain at least 1 number';
  }
  if (!symbolRegex.hasMatch(value)) {
    return 'Password must contain at least 1 symbol (!@#\$&*~%)';
  }
  return null;
  }

  String?  confirmPasswordControllerValidator(String? value) {return null;}

  /// Initialization and disposal methods.

  void initState(BuildContext context) {

  }

  void dispose() {
    oldPasswordController?.dispose();
    newPasswordController?.dispose();
    confirmPasswordController?.dispose();
  }


  /// Additional helper methods are added here.

  Future<String?> changePassword(String oldPassword, String newPassword, String confirmPassword) async {
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;

    // Re-authenticate the user to verify the old password
    final credential = EmailAuthProvider.credential(email: user!.email!, password: oldPassword);
    try {
      await user.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }

    // Validate the new password
    if (newPassword != confirmPassword) {
      return "New password and confirm password don't match.";
    }
    String? passwordError = ChangePasswordPageModel().newPasswordControllerValidator(newPassword);
    if (passwordError != null) {
      return passwordError;
    }

    // Update the password in Firebase Auth
    try {
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }

    // Update the password in Firestore
    final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    try {
      await userRef.update({'password': newPassword});
    } on FirebaseException catch (e) {
      return e.message;
    }

    // Return null if there are no errors
    return null;
  }


}
