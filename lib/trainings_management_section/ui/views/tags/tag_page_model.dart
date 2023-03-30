import '/flutter_utils/ff_util.dart';
import 'package:flutter/material.dart';

class TagPageModel extends FFModel {
  TextEditingController? tagLabelController;
  TextEditingController? tagColorController;

  String? tagLabelValidator(String? value) {
    if (value!.isEmpty) {
      return "Label is required !";
    }
    return null;
  }

  String? tagColorValidator(String? value) {
    if (value!.isEmpty) {
      return "Color is required !";
    }
    return null;
  }

  void initState(BuildContext context) {}

  void dispose() {
    tagLabelController?.dispose();
    tagColorController?.dispose();
  }
}
