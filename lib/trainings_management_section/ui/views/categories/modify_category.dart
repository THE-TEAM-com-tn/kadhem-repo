import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final _formKey = GlobalKey<FormState>();

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
              GTextFormField(
                  initVal: widget.category.name,
                  ifEmpty: "Category name is required",
                  onSaved: (value) => name = value!,
                  hint: "Category Name"),
              const SizedBox(
                height: 16,
              ),
              GTextFormField(
                  initVal: widget.category.description,
                  ifEmpty: "Category description is required",
                  onSaved: (value) => description = value!,
                  hint: "Category Description"),
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
