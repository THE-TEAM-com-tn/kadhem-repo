import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_elearny/flutter_utils/ff_theme.dart';
import 'package:team_elearny/flutter_utils/ff_util.dart';
import 'package:team_elearny/flutter_utils/ff_widgets.dart';
import 'package:team_elearny/trainings_management_section/ui/shared/input_widget.dart';
import 'package:team_elearny/trainings_management_section/ui/views/tags/tag_page_model.dart';
import '../../../core/models/tag_model.dart';
import '../../../core/viewmodels/tag_crud_model.dart';

class ModifyTag extends StatefulWidget {
  final Tag tag;

  const ModifyTag({super.key, required this.tag});

  @override
  ModifyTagState createState() => ModifyTagState();
}

class ModifyTagState extends State<ModifyTag> {
  late TagPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TagPageModel());
    _model.tagLabelController ??= TextEditingController();
    _model.tagColorController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  late String label;
  late String color;

  @override
  Widget build(BuildContext context) {
    final tagProvider = Provider.of<TagCRUDModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Modify Tag Details'),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                InputWidget(
                    model: _model.tagLabelController,
                    validator: _model.tagLabelValidator,
                    text: '013', // ### Label ###
                    obscureText: false),
                const SizedBox(
                  height: 16,
                ),
                InputWidget(
                    model: _model.tagColorController,
                    validator: _model.tagColorValidator,
                    text: '014', // ### Color ###
                    obscureText: false),
                const SizedBox(
                  height: 16,
                ),
                FFButtonWidget(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await tagProvider.updateTag(
                            Tag(label: label, color: color), widget.tag.id!);
                        Navigator.pop(context);
                      }
                    },
                    text: FFLocalizations.of(context).getText(
                      '017' /* Add Tag */,
                    ),
                    options: FFButtonOptions(
                      width: 130.0,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FFTheme.of(context).primaryBackground,
                      textStyle: FFTheme.of(context).bodyText1.override(
                            fontFamily: 'Lexend Deca',
                            color: FFTheme.of(context).primaryColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FFTheme.of(context).bodyText1Family),
                          ),
                      elevation: 1.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
