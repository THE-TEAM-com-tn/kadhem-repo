// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';

// class LessonDetailPage extends StatelessWidget {
//   final Map<String, dynamic> data;
//   LessonDetailPage({required this.data, required String docId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(data['lesson_title']),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//              // Text('Document ID: ${docId}'),
//               Text(data['lesson_reference']),

//               const SizedBox(height: 16.0),
//               Html(data: data['html']),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
