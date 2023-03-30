import '/flutter_utils/ff_util.dart';
import 'package:flutter/material.dart';

class CategoryPageModel extends FFModel {
  TextEditingController? categoryNameController;
  TextEditingController? categoryDescriptionController;

  String? categoryNameValidator(String? value) {
    if (value!.isEmpty) {
      return "Title is required !";
    }
    return null;
  }

  String? categoryDescriptionValidator(String? value) {
    if (value!.isEmpty) {
      return "Description is required !";
    }
    return null;
  }

  void initState(BuildContext context) {}

  void dispose() {
    categoryNameController?.dispose();
    categoryDescriptionController?.dispose();
  }
}
