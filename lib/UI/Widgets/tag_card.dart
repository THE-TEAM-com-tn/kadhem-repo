// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/tag_model.dart';
import '../../providers/tag_crud_model.dart';
import '../Pages/tags/modify_tag.dart';

class TagCard extends StatelessWidget {
  final Tag tag;
  const TagCard({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    final tagProvider = Provider.of<TagCRUDModel>(context);

    return GestureDetector(

      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ModifyTag(tag: tag)));
      },


      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Card(

              child: Column(
                  children: [
                    ListTile(

                      leading: Image.network(
                        'https://i.imgur.com/4UrxKj6.png',
                        height: 200,
                      ),



                      title: Text("Label: ${tag.label}"),
                      subtitle: Container(
                        child: (Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Color: ${tag.color}",
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ModifyTag(tag: tag),
                              ),
                            );
                          },
                        ),


                        IconButton(
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),

                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm'),
                                  content: const Text('Are you sure you want to delete this tag?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await tagProvider.removeTag(tag.id!);
                                        Navigator.pop(context);
                                        //  Navigator.pop(context);
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },


                        ),



                      ],
                    ),

                    ),

          ]))),
    );
  }
}
