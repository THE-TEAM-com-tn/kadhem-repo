import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'lesson_details.dart';

class MyLessonsPage extends StatelessWidget {

  const MyLessonsPage({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Lessons - Users Side'),
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('htmleditor')
            .orderBy('order')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

              final lessonTitle = data['lesson_title'] ?? '';

              final createdAt = data['created_at'] != null
                  ? DateFormat('dd MMMM yyyy').format(data['created_at'].toDate())
                  : '';

              final lessonReference = data['lesson_reference']?.toString() ?? '';

              final order = data['order'] != null
                  ? data['order']
                  : '';

              return ListTile(
                title: Text("Lesson Title:  $lessonTitle"),
                leading: Image.network(
                  'https://i.imgur.com/sJWr1hJ.png',
                  height: 60,
                ),
                subtitle: Text("Creation Date:  $createdAt   ||   Ref: $lessonReference  || order : $order"),
                trailing: Text("Ref: $lessonReference"),
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
}
