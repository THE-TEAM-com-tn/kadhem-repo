import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:provider_trainings/core/models/category_model.dart';
import 'package:provider_trainings/core/viewmodels/category_crud_model.dart';

class MultiSelect extends StatefulWidget {
  const MultiSelect({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> _selectedItems = [];
  List<TrainingCategory> _categories = [];

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
    final categoryProvider = Provider.of<CategoryCRUDModel>(context);

    return AlertDialog(
      title: const Text('Available Categories List'),
      content: StreamBuilder(
        stream: categoryProvider.fetchCategoriesAsStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            _categories = snapshot.data!.docs
                .map((doc) => TrainingCategory.fromJson(
                    doc.data() as Map<String, dynamic>, doc.id))
                .toList();
            return SingleChildScrollView(
              child: ListBody(
                children: _categories
                    .map(
                      (category) => CheckboxListTile(
                        value: _selectedItems.contains(category.name),
                        title: Text(category.name),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) =>
                            _itemChange(category.name, isChecked!),
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
