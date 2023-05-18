import 'package:flutter/material.dart';
import 'package:theteam_gyp/user-interface/utils/training_category.dart';

extension TaskTypeExtension on TrainingCategory {
  Color getColor() {
    switch (this) {
      case TrainingCategory.agile:
        return Colors.lightBlue;
      case TrainingCategory.devOPS:
        return Colors.amber[700]!;
      default:
        return Colors.redAccent;
    }
  }

  String toStringValue() {
    switch (this) {
      case TrainingCategory.agile:
        return "Agile";
      case TrainingCategory.devOPS:
        return "Dev. OPS";
      default:
        return "Todo";
    }
  }
}
