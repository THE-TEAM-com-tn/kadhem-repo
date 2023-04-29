import 'package:elearning_provider/UI/Pages/tags/list_tags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/tag_model.dart';
import '../../../providers/tag_crud_model.dart';
import '../../Widgets/G_text_form_field.dart';
import '../../Widgets/nav_bar.dart';

class ModifyTag extends StatefulWidget {
  final Tag tag;

  const ModifyTag({super.key, required this.tag});

  @override
  ModifyTagState createState() => ModifyTagState();
}

class ModifyTagState extends State<ModifyTag> {
  final _formKey = GlobalKey<FormState>();

  late String label;
  late String color;

  @override
  Widget build(BuildContext context) {
    color = widget.tag.color;
    final tagProvider = Provider.of<TagCRUDModel>(context);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize:const Size.fromHeight(60.0) ,
        child: CustomNavBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: <Widget>[
                GTextFormField(
                    initVal: widget.tag.label,
                    ifEmpty: "Tag label is required",
                    onSaved: (value) => label = value!,
                    hint: "Tag Name"),
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
                      await tagProvider.updateTag(
                          Tag(label: label, color: color), widget.tag.id!);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Update Tag',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
