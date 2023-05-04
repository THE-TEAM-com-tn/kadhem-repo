import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearning_provider/UI/Pages/tags/add_tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/tag_model.dart';
import '../../../providers/tag_crud_model.dart';
import '../../Widgets/nav_bar.dart';
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
      /* actions: [
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

        ],*/

      body: Consumer<TagCRUDModel>(builder:(context, value, child) {
        
        if (value.loadingTags)
        {value.getAllCTags(); }
        return !value.loadingTags ? ListView.builder(
                itemCount: value.allTags.length,
                itemBuilder: (buildContext, index) =>
                    TagCard(tag: value.allTags[index]),
              ) : CircularProgressIndicator();
      }, ),
     
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


/* StreamBuilder(
              stream: tagProvider.fetchTagsAsStream(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  tags = snapshot.data!.docs
                      .map((doc) => Tag.fromJson(
                          doc.data() as Map<String, dynamic>, doc.id))
                      .toList();
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: tags.length,
                      shrinkWrap: true,
                      itemBuilder: (buildContext, index) =>
                          TagCard(tag: tags[index]),
                    ),
                  );
                } else {
                  return const Text('Fetching...');
                }
              }),*/