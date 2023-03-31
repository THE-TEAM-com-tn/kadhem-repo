import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_elearny/flutter_utils/ff_model.dart';
import 'package:team_elearny/flutter_utils/ff_theme.dart';
import 'package:team_elearny/flutter_utils/ff_util.dart';
import 'package:team_elearny/flutter_utils/ff_widgets.dart';
import 'package:team_elearny/trainings_management_section/ui/shared/input_widget.dart';
import 'package:team_elearny/trainings_management_section/ui/views/categories/category_page_model.dart';
import '../../../core/models/category_model.dart';
import 'package:provider/provider.dart';
import '../../../core/viewmodels/category_crud_model.dart';
import '../../../ui/widgets/G_text_form_field.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  AddCategoryState createState() => AddCategoryState();
}

class AddCategoryState extends State<AddCategory> {
  late CategoryPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CategoryPageModel());
    _model.categoryNameController ??= TextEditingController();
    _model.categoryDescriptionController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  late String name;
  late String description;

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryCRUDModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Add Training Category'),
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
                    model: _model.categoryNameController,
                    validator: _model.categoryNameValidator,
                    text: '015', // ### Name ###
                    obscureText: false),
                const SizedBox(
                  height: 16,
                ),
                InputWidget(
                    model: _model.categoryDescriptionController,
                    validator: _model.categoryDescriptionValidator,
                    text: '016', // ### Description ###
                    obscureText: false),
                const SizedBox(
                  height: 16,
                ),
                FFButtonWidget(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await categoryProvider.addCategory(TrainingCategory(
                          name: name,
                          description: description,
                        ));
                        // Navigator.pushNamed(context, '/list_categories');
                        Navigator.pop(context);
                      }
                    },
                    text: FFLocalizations.of(context).getText(
                      '017' /* Add Category */,
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
