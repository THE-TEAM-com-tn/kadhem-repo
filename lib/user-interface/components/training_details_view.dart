import 'package:flutter/material.dart';
import 'package:theteam_gyp/core/models/training_model.dart';
import 'package:theteam_gyp/user-interface/components/training_details_card.dart';
import 'package:theteam_gyp/user-interface/constans/app_constants.dart';

class TrainingDetailsView extends StatelessWidget {
  const TrainingDetailsView(
      {super.key, required this.training, required this.isLogged});

  final Axis axis = Axis.horizontal;
  final TrainingModel training;
  final bool isLogged;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          child: (axis == Axis.horizontal)
              ? Row(
                  children: [
                    Flexible(
                      flex: 9,
                      child: TrainingDetailsCard(
                          isLogged: isLogged, data: training),
                    )
                  ],
                )
              : Column(
                  children: [
                    TrainingDetailsCard(isLogged: isLogged, data: training),
                  ],
                ),
        ));
  }
}
