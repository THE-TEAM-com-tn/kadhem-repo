// ignore_for_file: file_names

import 'package:elearning_provider/UI/Pages/tags/list_tags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/tag_model.dart';
import '../../providers/tag_crud_model.dart';
import '../Pages/tags/modify_tag.dart';

class TagCard extends StatefulWidget {
  final TagCRUDModel refresh;
  final Tag tag;
  const TagCard({super.key, required this.tag, required this.refresh});

  @override
  State<TagCard> createState() => _TagCardState();
}

class _TagCardState extends State<TagCard> {
  bool deleted = false;
  @override
  Widget build(BuildContext context) {
    final tagProvider = Provider.of<TagCRUDModel>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ModifyTag(
                      tag: widget.tag,
                    )));
      },
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
              shadowColor: Colors.black,
              elevation: 3.0,
              child: Column(children: [
                ListTile(
                  leading: Image.network(
                    'https://i.imgur.com/4UrxKj6.png',
                    height: MediaQuery.of(context).size.width > 600 ? 200 : 100,
                  ),
                  title: Text("Label: ${widget.tag.label}"),
                  subtitle: Container(
                    child: (Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Color: ${widget.tag.color}",
                            style: const TextStyle(fontSize: 14)),
                      ],
                    )),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) => ModifyTag(
                                    tag: widget.tag,
                                  ));
                          final state =
                              context.findAncestorStateOfType<ListTagsState>();
                          state!.setState(() {
                            widget.refresh.loadingTags = true;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) => SimpleDialog(
                                    children: [
                                      const Text(
                                          'Are you sure you want to delete this tag?'),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('No', style : TextStyle(color: Colors.red)),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await tagProvider
                                              .removeTag(widget.tag.id!)
                                              .then((value) {});

                                          Navigator.pop(context);
                                        },
                                        child: const Text('Yes', style : TextStyle(color: Colors.green)),
                                      ),
                                    ],
                                  ));

                          final state =
                              context.findAncestorStateOfType<ListTagsState>();

                          state!.setState(() {
                            widget.refresh.loadingTags = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ]))),
    );
  }
}
