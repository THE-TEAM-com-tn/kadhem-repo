import 'package:flutter/material.dart';
import 'package:theteam_gyp/user-interface/trainings/expantion_panel.dart';

class TrainingsMain extends StatelessWidget {
  const TrainingsMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 100, 0, 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Course(),
      ),
    );
  }
}
