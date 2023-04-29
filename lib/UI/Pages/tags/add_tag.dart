import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/tag_model.dart';
import '../../../providers/tag_crud_model.dart';
import '../../Widgets/G_text_form_field.dart';
import '../../Widgets/nav_bar.dart';

class AddTag extends StatefulWidget {
  const AddTag({super.key});

  @override
  AddTagState createState() => AddTagState();
}

class AddTagState extends State<AddTag> {
  final _formKey = GlobalKey<FormState>();
  late String label;
  String color= 'red';

  @override
  Widget build(BuildContext context) {
    var tagProvider = Provider.of<TagCRUDModel>(context);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize:const Size.fromHeight(60.0) ,
        child: CustomNavBar(),
      )
      ,
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
                DropdownButtonFormField<String>(
                    value: color,
                    items: <String>['red', 'yellow', 'green', 'blue']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      color = value!;
                    }),
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
                        color: color,
                      ));
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
