import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../models/category_model.dart';
import '../../../providers/category_crud_model.dart';
import '../../Widgets/G_text_form_field.dart';
import '../../Widgets/nav_bar.dart';


class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  AddCategoryState createState() => AddCategoryState();
}

class AddCategoryState extends State<AddCategory> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String description;

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryCRUDModel>(context);
    return SimpleDialog(
      children : [ Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,

          child: Center(
            child: Column(
              children: <Widget>[
                GTextFormField(
                    ifEmpty: "Category name is required",
                    onSaved: (value) => name = value!,
                    hint: "Category Title"),
                const SizedBox(
                  height: 16,
                ),
                GTextFormField(
                    ifEmpty: "Category description is required",
                    onSaved: (value) => description = value!,
                    hint: "Category description"),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  // splashColor: Colors.red,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await categoryProvider.addCategory(TrainingCategory(
                          name: name,
                          description: description,));
                      // Navigator.pushNamed(context, '/list_categories');
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add Category',
                      style: TextStyle(color: Colors.white)),
                  // color: Colors.blue,
                )
              ],
            ),
          ),
        ),
      )],
    );
  }
}
