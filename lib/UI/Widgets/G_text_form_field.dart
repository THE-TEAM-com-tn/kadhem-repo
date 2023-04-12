// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class GTextFormField extends StatelessWidget {
  dynamic initVal;
  String ifEmpty;
  String hint;
  final void Function(String?)? onSaved;

  GTextFormField(
      {super.key,
      this.initVal,
      required this.ifEmpty,
      required this.onSaved,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initVal,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        fillColor: Colors.grey[300],
        filled: true,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return ifEmpty;
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
