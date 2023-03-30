import '/flutter_utils/ff_util.dart';
import 'package:flutter/material.dart';

class TrainingPageModel extends FFModel {
  TextEditingController? trainingTitleController;
  TextEditingController? trainingDescriptionController;
  TextEditingController? trainingAuthorController;
  TextEditingController? trainingDurationController;
  TextEditingController? trainingPriceController;
  TextEditingController? trainingTrailerVidController;

  ///  State fields for stateful widgets in this page.

  // bool isMediaUploading = false;
  // FFUploadedFile uploadedLocalFile =
  //     FFUploadedFile(bytes: Uint8List.fromList([]));

  String? trainingTitleValidator(String? value) {
    if (value!.isEmpty) {
      return "Title is required !";
    }
    return null;
  }

  String? trainingDescriptionValidator(String? value) {
    if (value!.isEmpty) {
      return "Description is required !";
    }
    return null;
  }

  String? trainingAuthorValidator(String? value) {
    if (value!.isEmpty) {
      return "Author is required !";
    }
    return null;
  }

  String? trainingDurationValidator(String? value) {
    if (value!.isEmpty) {
      return "Duration is required !";
    }
    return null;
  }

  String? trainingPriceValidator(String? value) {
    if (value!.isEmpty) {
      return "Price is required !";
    }
    return null;
  }

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    trainingTitleController?.dispose();
    trainingDescriptionController?.dispose();
    trainingAuthorController?.dispose();
    trainingDurationController?.dispose();
    trainingPriceController?.dispose();
    trainingTrailerVidController?.dispose();
  }
}
