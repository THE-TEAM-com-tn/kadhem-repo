import 'package:elearning_provider/UI/Pages/categories/list_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/category_model.dart';
import '../../../providers/category_crud_model.dart';
import '../../Widgets/G_text_form_field.dart';

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
/*<<<<<<< HEAD*/
          child: Column(
            children: <Widget>[
              GTextFormField(
                  initVal: widget.category.name,
                  ifEmpty: "Category name is required",
                  onSaved: (value) => name = value!,
                  hint: "Category Name"),
              const SizedBox(
                height: 16,

                /// CONFLICT HERE !!!

                /*  =======
                                DON'T DELETE THIS UNTILL WE SOLVE THE CONFLICTS !

              child: Container(
              padding: EdgeInsets.all(25.0),
          child: Center(
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
                >>>>>>> 3f0208f6a22b6ef32aba132f723c6772afe5023f*/

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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ListCategories()));
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
