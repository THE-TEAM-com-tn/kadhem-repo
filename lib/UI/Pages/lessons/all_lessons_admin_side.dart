import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'lesson_details.dart';

class AllLessons extends StatefulWidget {
  @override
  _AllLessonsState createState() => _AllLessonsState();
}

class _AllLessonsState extends State<AllLessons> {
  List<DocumentSnapshot> _documents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Lessons - Admins Side (Re-OrdableList)'),
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('htmleditor').orderBy('order').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          _documents = snapshot.data!.docs;
          return ReorderableListView(
            onReorder: _onReorder,
            children: _documents.map((document) {
              final Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
              if (data == null) {
                return const SizedBox();
              }
              final lessonTitle = data['lesson_title'] as String?;
              final createdAt = data['created_at'] != null ? DateFormat('dd MMMM yyyy').format(data['created_at'].toDate()) : '';
              final lessonReference = data['lesson_reference']?.toString() ?? '';
              return ListTile(
                key: ValueKey(document.id),
                leading: Image.network(
                  'https://i.imgur.com/sJWr1hJ.png',
                  height: 60,
                ),
                title: Text(lessonTitle ?? 'Untitled'),
                subtitle: Text('Created at: $createdAt || Ref: $lessonReference'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LessonDetailPage(data: data, docId: document.id)),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final document = _documents.removeAt(oldIndex);
    _documents.insert(newIndex, document);
    setState(() {});
    _saveLessonOrder(); // save the new order to Firestore database
  }


  void _saveLessonOrder() {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final collection = FirebaseFirestore.instance.collection('htmleditor');
      for (int i = 0; i < _documents.length; i++) {
        final document = _documents[i];
        final docRef = collection.doc(document.id);
        await transaction.update(docRef, {
          'order': i,
        });
      }
    });
  }

  @override
  void dispose() {
    _saveLessonOrder();
    super.dispose();
  }
}
