import 'package:flutter/material.dart';
import '../../../flutter_utils/ff_theme.dart';
import '../../../flutter_utils/internationalization.dart';

class InputWidget extends StatefulWidget {
  final model;
  final String? Function(String?)? validator;
  final text;
  final enabled;
  final initialValue;
  final maxLines;
  final onChanged;
  final obscureText;

  const InputWidget(
      {Key? key,
      this.initialValue = "",
      required this.model,
      this.validator,
      required this.text,
      this.enabled,
      this.onChanged,
      required this.obscureText,
      this.maxLines})
      : super(key: key);

  @override
  State<InputWidget> createState() => InputWidgetState();
}

class InputWidgetState extends State<InputWidget> {
  late var _model;

  late String? Function(String?) _validator;

  late var _text;

  @override
  void initState() {
    super.initState();
    _model = widget.model;
    _validator = widget.validator!;
    _text = widget.text;
    _model.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
      child: widget.obscureText
          ? Container(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                enabled: widget.enabled,
                controller: _model,
                onChanged: widget.onChanged,
                obscureText: widget.obscureText,
                validator: _validator,
                decoration: InputDecoration(
                  labelText: FFLocalizations.of(context).getText(
                    _text /* Your Name */,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: FFTheme.of(context).secondaryBackground,
                    width: 1.0,
                  )),
                  labelStyle: FFTheme.of(context).bodyText2,
                  hintStyle: FFTheme.of(context).bodyText2,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FFTheme.of(context).primaryBackground,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: FFTheme.of(context).secondaryBackground,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
                ),
                style: FFTheme.of(context).bodyText1,
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width / 3,
              child: TextFormField(
                enabled: widget.enabled,
                controller: _model,
                onChanged: widget.onChanged,
                maxLines: widget.maxLines,
                validator: _validator,
                decoration: InputDecoration(
                  labelText: FFLocalizations.of(context).getText(
                    _text /* Your Name */,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: FFTheme.of(context).secondaryBackground,
                    width: 1.0,
                  )),
                  labelStyle: FFTheme.of(context).bodyText2,
                  hintStyle: FFTheme.of(context).bodyText2,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FFTheme.of(context).primaryBackground,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: FFTheme.of(context).secondaryBackground,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
                ),
                style: FFTheme.of(context).bodyText1,
              ),
            ),
    );
  }
}
