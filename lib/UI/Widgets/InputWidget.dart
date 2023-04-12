// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final model;

  final String? Function(String?) validator;

  final text;

  final enabled;

  final initialValue;

  final maxLines;

  final onChanged;

  final bool obcure;

  const InputWidget(
      {super.key,
      required this.validator,
      required this.model,
      required this.text,
      required this.initialValue,
      required this.enabled,
      required this.maxLines,
      required this.onChanged,
      required this.obcure});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late var _model;
  bool _passwordVisible = true;
  late bool _obscure;

  @override
  void initState() {
    _model = widget.model;
    _model.text = widget.initialValue;
    _obscure = widget.obcure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      validator: widget.validator,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      controller: _model,
      decoration: _obscure
          ? InputDecoration(
              label: Text(widget.text),
              suffixIcon: IconButton(
                icon: Icon(
                  !_passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            )
          : null,
      obscureText: _obscure ? _passwordVisible : false,
    );
  }
}
