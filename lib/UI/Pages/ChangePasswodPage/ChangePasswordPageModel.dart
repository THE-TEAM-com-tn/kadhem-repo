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

}
