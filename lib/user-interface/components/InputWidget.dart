// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final model;

  final String? Function(String?)? validator;

  final text;

  final enabled;

  final initialValue;

  final maxLines;

  final onChanged;

  final bool obcure;

  final IconData? icon ;
  const InputWidget(
      {super.key,
      this.validator,
      this.model,
      required this.text,
      required this.initialValue,
      required this.enabled,
      required this.maxLines,
      required this.onChanged,
      required this.obcure,
      this.icon});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late var _model;
  bool _passwordVisible = true;
  late bool _obscure;

  @override
  void initState() {
    if (widget.model != null) {
      _model = widget.model;
      _model.text = widget.initialValue;
    } else {
      _model = TextEditingController();
      _model.text = widget.initialValue ; 
    }

    _obscure = widget.obcure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      validator: widget.validator ?? (value) {},
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      controller: _model,
      decoration: InputDecoration(
        label: Text(widget.text),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.red)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.green)),
        suffixIcon: _obscure
            ? IconButton(
                icon: Icon(
                  !_passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : null,
        prefixIcon: widget.icon != null  ? Icon(
          widget.icon
        ) : null
      ),
      obscureText: _obscure ? _passwordVisible : false,
    );
  }
}
