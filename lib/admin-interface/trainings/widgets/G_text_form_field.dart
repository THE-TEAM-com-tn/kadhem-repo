// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class GTextFormField extends StatelessWidget {
  final dynamic initVal;
  final String ifEmpty;
  final String hint;
  final void Function(String?)? onSaved;
  final int? maxLines; // <-- add maxLines parameter

  GTextFormField({
    Key? key,
    required this.initVal,
    required this.ifEmpty,
    required this.onSaved,
    required this.hint,
    this.maxLines, required InputDecoration? decoration, // <-- add maxLines parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initVal,
      decoration: InputDecoration(
        hintText: hint,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return ifEmpty;
        }
        return null;
      },
      onSaved: onSaved,
      maxLines: maxLines, // <-- pass maxLines to the TextFormField widget
    );
  }
}
