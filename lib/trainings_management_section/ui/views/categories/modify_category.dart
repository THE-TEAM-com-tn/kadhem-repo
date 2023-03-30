import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_elearny/flutter_utils/ff_model.dart';
import 'package:team_elearny/trainings_management_section/ui/shared/input_widget.dart';
import 'package:team_elearny/trainings_management_section/ui/views/tags/tag_page_model.dart';
import '../../../core/models/category_model.dart';
import '../../../core/viewmodels/category_crud_model.dart';
import '../../../ui/widgets/G_text_form_field.dart';

class ModifyCategory extends StatefulWidget {
  final TrainingCategory category;

  const ModifyCategory({super.key, required this.category});

  @override
  ModifyCategoryState createState() => ModifyCategoryState();
}

class ModifyCategoryState extends State<ModifyCategory> {
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

  late String name;
  late String description;

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryCRUDModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Modify Category Details'),
        ),
      ),
      body: Padding(
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
              ElevatedButton(
                // splashColor: Colors.red,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await categoryProvider.updateCategory(
                        TrainingCategory(name: name, description: description),
                        widget.category.id!);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update Category',
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
