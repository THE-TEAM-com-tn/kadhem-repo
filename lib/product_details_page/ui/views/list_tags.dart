import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/models/tag_model.dart';
import '../../core/viewmodels/tag_crud_model.dart';
import '../../ui/widgets/tag_card.dart';
import 'package:provider/provider.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_tag');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Tags Management"),
      ),
      body: StreamBuilder(
          stream: tagProvider.fetchTagsAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              tags = snapshot.data!.docs
              .map((doc) => Tag.fromJson(doc.data() as Map<String, dynamic>, doc.id))
              .toList();
              return ListView.builder(
                itemCount: tags.length,
                itemBuilder: (buildContext, index) => TagCard(tag: tags[index]),
              );
            } else {
              return const Text('fetching');
            }
          }),
    );
  }
}
