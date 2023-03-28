import 'package:flutter/material.dart';
import '../../core/models/category_model.dart';
import 'package:provider/provider.dart';
import '../../core/viewmodels/category_crud_model.dart';
import '../../ui/widgets/G_text_form_field.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Add Training Category'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
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
    );
  }
}
