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

      body: Consumer<TagCRUDModel>(
        builder: (context, value, child) {
          var size = MediaQuery.of(context).size;
          final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
          final double itemWidth = size.width / 2;
          if (value.loadingTags) {
            value.getAllCTags();
          }
          return !value.loadingTags
              ? Column(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => AddTag()).then((val) {
                                setState(() {
                                  value.loadingTags = true ; 
                                });
                              });
                          setState(() {
                            value.loadingTags;
                          });
                        },
                        child: Text('Add Tag')),
                    Expanded(
                      child: MediaQuery.of(context).size.width > 600 ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: itemWidth/itemHeight ,
                            crossAxisCount: 2 ),
                        itemCount: value.allTags.length,
                        itemBuilder: (buildContext, index) =>
                            TagCard(tag: value.allTags[index], refresh: value),
                      ) : 
                      ListView.builder(
                        itemCount: value.allTags.length,
                        itemBuilder: (buildContext, index) =>
                            TagCard(tag: value.allTags[index], refresh: value),
                      ),
                    ),
                  ],
                )
              : CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: const Icon(Icons.add),
      ),
    );
  }

  refresh () {
    setState() {}
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