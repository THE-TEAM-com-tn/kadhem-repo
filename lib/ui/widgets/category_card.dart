// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_trainings/core/models/category_model.dart';
import 'package:provider_trainings/core/viewmodels/category_crud_model.dart';
import 'package:provider_trainings/ui/views/modify_category.dart';

class CategoryCard extends StatelessWidget {
  final TrainingCategory category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryCRUDModel>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ModifyCategory(category: category)));
      },
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            child: Column(
              children: [
              AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await categoryProvider.removeCategory(category.id!);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            ListTile(
              title: Text("Title: ${category.name}"),
              subtitle: Container(
                child: (Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Category: ${category.description}", style: const TextStyle(fontSize: 14)),
                  ],
                )),
              ),
            ),
          ]))),
    );
  }
}
