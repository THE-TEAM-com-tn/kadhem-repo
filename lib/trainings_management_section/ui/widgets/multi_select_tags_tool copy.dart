import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:team_elearny/trainings_management_section/core/models/tag_model.dart';
import 'package:team_elearny/trainings_management_section/core/viewmodels/tag_crud_model.dart';

class MultiSelectTags extends StatefulWidget {
  const MultiSelectTags({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectStateTags();
}

class _MultiSelectStateTags extends State<MultiSelectTags> {
  final List<String> _selectedItems = [];
  List<Tag> _tags = [];

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    final tagProvider = Provider.of<TagCRUDModel>(context);

    return AlertDialog(
      title: const Text('Available Tags List'),
      content: StreamBuilder(
        stream: tagProvider.fetchTagsAsStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            _tags = snapshot.data!.docs
                .map((doc) =>
                    Tag.fromJson(doc.data() as Map<String, dynamic>, doc.id))
                .toList();
            return SingleChildScrollView(
              child: ListBody(
                children: _tags
                    .map(
                      (tag) => CheckboxListTile(
                        value: _selectedItems.contains(tag.label),
                        title: Text(tag.label),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) =>
                            _itemChange(tag.label, isChecked!),
                      ),
                    )
                    .toList(),
              ),
            );
          } else {
            return const Text('fetching');
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
