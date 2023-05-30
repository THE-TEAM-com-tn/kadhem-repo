// ignore_for_file: file_names

import 'package:flutter/material.dart';

class EditProfilePageModel {


  TextEditingController? yourNameController;
  String? yourNameControllerValidator(String? value) {
    if (value!.isEmpty) {
      return "Please enter a value";
    }
    return null;
  }

  // State field(s) for emailAddress widget.
  TextEditingController? emailAddressController;
  String? emailAddressControllerValidator(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value!.isEmpty) {
      return 'Email is required';
    }
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  // State field(s) for myBio widget.
  TextEditingController? myBioController;
  String? myBioControllerValidator(String? value) {
    return null;
  }

  TextEditingController? phoneNumberController;
  String? phoneNumberControllerValidator(String? value) {
    if (value!.trim().isEmpty) {
      return 'Field is required';
    }
    if (int.tryParse(value) == null) {
      return 'Field must be a numeric string';
    }
    return null;
  }

  TextEditingController? addressController;
  String? addressControllerValidator(String? value) {
    return null;
  }

  TextEditingController? companyController;
  String? companyControllerValidator(String? value) {
    return null;
  }

  TextEditingController? lastNameController;
  String? lastNameControllerValidator(String? value) {
    if (value!.trim().isEmpty) {
      return "Please enter a value";
    }
    return null;
  }

  TextEditingController? birthDateController;
  String? birthDateControllerValidator(String? value) {
    return null;
  }

  /// Initialization and disposal methods.

  void dispose() {
    yourNameController?.dispose();
    lastNameController?.dispose();
    emailAddressController?.dispose();
    phoneNumberController?.dispose() ;
    birthDateController?.dispose() ;
    addressController?.dispose() ; 
    companyController?.dispose() ;
    myBioController?.dispose();
  }

}