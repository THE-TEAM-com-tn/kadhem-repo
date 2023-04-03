import 'package:team_elearny/components/web_nav_model.dart';
import 'package:team_elearny/trainings_management_section/core/viewmodels/training_crud_model.dart';

import '/flutter_utils/ff_util.dart';
import 'package:flutter/material.dart';

class TrainingPageModel extends FFModel {
  // Model for webNav component.
  late WebNavModel webNavModel;

  TextEditingController? trainingTitleController;
  TextEditingController? trainingDescriptionController;
  TextEditingController? trainingAuthorController;
  TextEditingController? trainingDurationController;
  TextEditingController? trainingPriceController;
  TextEditingController? trainingTrailerVidController;

  TextEditingController? trainingSearchController;

  // late TrainingCRUDModel crudModel;

  // Future<String?> trainingTitleValidator(String? value) async {
  //   if (value!.isEmpty) {
  //     return "Title is required !";
  //   } else if (await crudModel.isThere("title", value)) {
  //     return "Title already exsists!";
  //   }
  //   return null;
  // }

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

  void initState(BuildContext context) {
    webNavModel = createModel(context, () => WebNavModel());
  }

  void dispose() {
    webNavModel.dispose();

    trainingTitleController?.dispose();
    trainingDescriptionController?.dispose();
    trainingAuthorController?.dispose();
    trainingDurationController?.dispose();
    trainingPriceController?.dispose();
    trainingTrailerVidController?.dispose();

    trainingSearchController?.dispose();
  }
}
