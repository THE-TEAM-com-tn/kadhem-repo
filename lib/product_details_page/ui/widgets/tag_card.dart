// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/tag_model.dart';
import '../../core/viewmodels/tag_crud_model.dart';
import '../../ui/views/modify_tag.dart';

class TagCard extends StatelessWidget {
  final Tag tag;
  const TagCard({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    final tagProvider = Provider.of<TagCRUDModel>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ModifyTag(tag: tag)));
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
                    await tagProvider.removeTag(tag.id!);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            ListTile(
              title: Text("Label: ${tag.label}"),
              subtitle: Container(
                child: (Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Color: ${tag.color}", style: const TextStyle(fontSize: 14)),
                  ],
                )),
              ),
            ),
          ]))),
    );
  }
}
