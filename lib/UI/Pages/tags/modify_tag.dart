import 'package:elearning_provider/UI/Pages/tags/list_tags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/tag_model.dart';
import '../../../providers/tag_crud_model.dart';
import '../../Widgets/G_text_form_field.dart';


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
    final tagProvider = Provider.of<TagCRUDModel>(context);

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
        title: const Center(
          child: Text('Modify Tag Details'),
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
                    initVal: widget.tag.label,
                    ifEmpty: "Tag label is required",
                    onSaved: (value) => label = value!,
                    hint: "Tag Name"),
                const SizedBox(
                  height: 16,
                ),
                GTextFormField(
                    initVal: widget.tag.color,
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
                      await tagProvider.updateTag(
                          Tag(label: label, color: color), widget.tag.id!);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ListTags()));
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
