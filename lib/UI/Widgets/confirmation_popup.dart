import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ConfirmationPopUp extends StatelessWidget {
  final String text;
  const ConfirmationPopUp({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        children:[ Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30,),
          const Icon(Icons.task_alt, color: Colors.green, size: 50),
          SizedBox(height: 30,),
          Text(text),
          SizedBox(height: 30,),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Okay"))
        ],
      ),
    )]);
  }
}
