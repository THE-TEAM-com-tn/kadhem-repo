import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearning_provider/UI/Pages/tags/add_tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/tag_model.dart';
import '../../../providers/tag_crud_model.dart';
import '../../Widgets/tag_card.dart';

class ListTags extends StatefulWidget {
  const ListTags({super.key});

  @override
  ListTagsState createState() => ListTagsState();
}

class ListTagsState extends State<ListTags> {
  late List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    final tagProvider = Provider.of<TagCRUDModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200], // Set the background color to transparent
        elevation: 0,
        title: const Text("Tags Management"),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTag()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                'https://i.imgur.com/YEGyoAc.png',
                height: 32,
                width: 32,
              ),
            ),
          ),

        ],
      ),
      body: StreamBuilder(
          stream: tagProvider.fetchTagsAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              tags = snapshot.data!.docs
                  .map((doc) =>
                      Tag.fromJson(doc.data() as Map<String, dynamic>, doc.id))
                  .toList();
              return ListView.builder(
                itemCount: tags.length,
                itemBuilder: (buildContext, index) => TagCard(tag: tags[index]),
              );
            } else {
              return const Text('Fetching...');
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddTag()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
