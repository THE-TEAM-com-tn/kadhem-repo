import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/tag_model.dart';
import '../../../providers/tag_crud_model.dart';
import '../../Widgets/G_text_form_field.dart';


class AddTag extends StatefulWidget {
  const AddTag({super.key});

  @override
  AddTagState createState() => AddTagState();
}

class AddTagState extends State<AddTag> {
  final _formKey = GlobalKey<FormState>();
  late String label;
  late String color;

  @override
  Widget build(BuildContext context) {
    var tagProvider = Provider.of<TagCRUDModel>(context);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
        title: const Center(
          child: Text('Add Tag'),
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,


          child: Center(
            child: Column(
              children: <Widget>[
                GTextFormField(
                    ifEmpty: "Tag label is required",
                    onSaved: (value) => label = value!,
                    hint: "Tag Label"),
                const SizedBox(
                  height: 16,
                ),
                GTextFormField(
                    ifEmpty: "Tag color is required",
                    onSaved: (value) => color = value!,
                    hint: "Tag Color"),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  // splashColor: Colors.red,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await tagProvider.addTag(Tag(
                          label: label,
                          color: color,));
                      // Navigator.pushNamed(context, '/list_categories');
                      Navigator.pop(context);
                    }
                  },

                  child: const Text('Add Tag',
                      style: TextStyle(color: Colors.white)),
                  // color: Colors.blue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
