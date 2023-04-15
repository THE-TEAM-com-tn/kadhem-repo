import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearning_provider/models/PasswordChangeModel.dart';
import 'package:elearning_provider/services/ChangePasswordService.dart';
import 'package:flutter/material.dart';

import '../locator.dart';

class PasswordChangeProvider with ChangeNotifier {
  String result = "";
  bool lower = false,
      upper = false,
      symbol = false,
      length = false,
      number = false;
  final ChangePasswordService _api = locator<ChangePasswordService>();
  DocumentSnapshot? _documentSnapshot;

  updatePassword(PasswordChangeModel passwordChangeModel, String doc) async {
    result = await _api.updatePassword(passwordChangeModel, doc);
    notifyListeners();
    return result;
  }

  verifyRequirements(String value) {
    final upperCaseRegex = RegExp(r'[A-Z]');
    final lowerCaseRegex = RegExp(r'[a-z]');
    final numberRegex = RegExp(r'[0-9]');
    final symbolRegex = RegExp(r'[!@#\$&*~%]');

    if (value.length > 8) {
      length = true;
    } else {
      length = false;
    }
    if (upperCaseRegex.hasMatch(value)) {
      upper = true;
    } else {
      upper = false;
    }
    if (lowerCaseRegex.hasMatch(value)) {
      lower = true;
    } else {
      lower = false;
    }
    if (numberRegex.hasMatch(value)) {
      number = true;
    } else {
      number = false;
    }
    if (symbolRegex.hasMatch(value)) {
      symbol = true;
    } else {
      symbol = false;
    }
    notifyListeners();
  }
}
