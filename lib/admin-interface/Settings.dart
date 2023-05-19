// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:theteam_gyp/admin-interface/ChangePasswodPage/ChangePasswordPage.dart';
// import 'package:theteam_gyp/admin-interface/EditProfilePage/EditProfilePageWidget.dart';
// import 'package:theteam_gyp/admin-interface/categories/list_categories.dart';
// import 'package:theteam_gyp/admin-interface/home_page.dart';
// import 'package:theteam_gyp/admin-interface/lessons/all_lessons_admin_side.dart';
// import 'package:theteam_gyp/admin-interface/lessons/user_side_of_all_lessons.dart';
// import 'package:theteam_gyp/admin-interface/tags/list_tags.dart';
// import 'package:theteam_gyp/admin-interface/trainings/list_trainings.dart';
// import 'package:theteam_gyp/admin-interface/users_list_page.dart';
// import 'package:theteam_gyp/admin-interface/welcome_screen.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'AdminDashboardPage.dart';

// class SettingsPage extends StatelessWidget {
//   final String? userId;
//   SettingsPage({Key? key, this.userId})
//       : super(key: key); //required UserModel userModel

//   Stream<int> getUserCount() {
//     return FirebaseFirestore.instance
//         .collection('users')
//         .snapshots()
//         .map((querySnapshot) => querySnapshot.size);
//   }

//   Stream<int> getTrainingCount() {
//     return FirebaseFirestore.instance
//         .collection('trainings')
//         .snapshots()
//         .map((querySnapshot) => querySnapshot.size);
//   }

//   final Stream<List<DocumentSnapshot>> htmleditorStream = FirebaseFirestore
//       .instance
//       .collection('htmleditor')
//       .snapshots()
//       .map((QuerySnapshot querySnapshot) {
//     return querySnapshot.docs;
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor:
//             Colors.deepPurple[200], // Set the background color to deep purple
//         elevation: 0,

//         leading: IconButton(
//           icon: const Icon(Icons.account_box, color: Colors.white),
//           onPressed: () {
//             // This Icon button will redirect you to the user profile page or User's Settings Page !
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     DashboardAdminSummaryWidget(), // userId: userId
//               ),
//             );
//           },
//         ),

//         title: const Center(
//           child: Text(
//             "welcome",
//             //user.email!, // this will display the user email in the app bar
//             style: TextStyle(fontSize: 16),
//           ),
//         ),

//         actions: [
//           TextButton.icon(
//             onPressed: signUserOut,
//             icon: const Icon(Icons.logout, color: Colors.white),
//             label: const Text(
//               "Logout",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 15,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Text('User ID: $userId'),
//             const SizedBox(height: 6),
//             const Text(
//               "This is the Weclome/Home Page , these buttons will be on the Side NavBar",
//               style: TextStyle(fontSize: 20),
//             ),

//             // USER COUNT
//             StreamBuilder<int>(
//               stream: getUserCount(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Text('Number of users: ${snapshot.data}');
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return CircularProgressIndicator();
//                 }
//               },
//             ),
//             ///// USER COUNT

//             const SizedBox(height: 15),

//             // TRAININGS COUNT
//             StreamBuilder<int>(
//               stream: getTrainingCount(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Text('Number of trainings: ${snapshot.data}');
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return CircularProgressIndicator();
//                 }
//               },
//             ),

//             ///// TRAININGS COUNT

//             const SizedBox(height: 30),

//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ProfilePageWidget(),
//                   ),
//                 );
//               },
//               child: const Text('Edit Profile (New)'),
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.deepOrangeAccent,
//               ),
//             ),

//             const SizedBox(height: 16),

//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const AdminSettingsPageWidget(),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.deepPurpleAccent,
//               ),
//               child: const Text('Admin Settings Page'),
//             ),

//             const SizedBox(height: 10),

//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const ChangePasswordPage()));
//                 },
//                 child: const Text("Change Password Page")),

//             const SizedBox(height: 15),

//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const ListTags()));
//                 },
//                 child: const Text("Tags page")),
//             const SizedBox(height: 15),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const ListCategories()));
//                 },
//                 child: const Text("Categories page")),
//             const SizedBox(height: 15),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const ListTrainings()));
//                 },
//                 child: const Text("Trainings page")),
//             const SizedBox(height: 15),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => HomePage(),
//                     ),
//                   );
//                 },
//                 child: const Text("HomePage / User Profile")),
//             const SizedBox(height: 15),
//             ElevatedButton(
//                 onPressed: () {
//                   /* ListUsers();*/
//                   print("this button does nothing");
//                 },
//                 child: const Text("Button Sample")),
//             const SizedBox(
//               height: 15,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const UsersList()));
//                 },
//                 child: const Text("Users List")),
//             SizedBox(
//               height: 15,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => HomePage()));
//                 },
//                 child: const Text("Add Users")),

//             const SizedBox(height: 30),

//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => AllLessons(),
//                   ),
//                 );
//               },
//               child: const Text('View All Lessons Admin side'),
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.deepOrangeAccent,
//               ),
//             ),

//             const SizedBox(height: 30),

//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => MyLessonsPage(),
//                   ),
//                 );
//               },
//               child: const Text('View All Lessons User side'),
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.deepOrangeAccent,
//               ),
//             ),

//             const SizedBox(height: 40),

//             StreamBuilder<List<DocumentSnapshot>>(
//               stream: htmleditorStream,
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 }
//                 final htmleditorDocs = snapshot.data!;
//                 final userCountMap = <DateTime, int>{};
//                 for (final doc in htmleditorDocs) {
//                   final createdAt = (doc['created_at'] as Timestamp).toDate();
//                   final day = DateTime.utc(
//                       createdAt.year, createdAt.month, createdAt.day);
//                   userCountMap[day] = (userCountMap[day] ?? 0) + 1;
//                 }

//                 final chartData = userCountMap.entries
//                     .map((entry) => _ChartData(entry.key, entry.value))
//                     .toList();

//                 return SizedBox(
//                   height: 200,
//                   child: charts.TimeSeriesChart(
//                     [
//                       charts.Series<_ChartData, DateTime>(
//                         id: 'User Count',
//                         colorFn: (_, __) =>
//                             charts.MaterialPalette.blue.shadeDefault,
//                         domainFn: (data, _) => data.time,
//                         measureFn: (data, _) => data.count,
//                         data: chartData,
//                       ),
//                     ],
//                     animate: true,
//                     animationDuration: Duration(milliseconds: 500),
//                     domainAxis: charts.DateTimeAxisSpec(
//                       tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
//                         minute: charts.TimeFormatterSpec(
//                           format: 'h:mm a',
//                           transitionFormat: 'h:mm a',
//                         ),
//                         hour: charts.TimeFormatterSpec(
//                           format: 'h:mm a',
//                           transitionFormat: 'h:mm a',
//                         ),
//                         day: charts.TimeFormatterSpec(
//                           format: 'MMM d',
//                           transitionFormat: 'MMM d, y',
//                         ),
//                         year: charts.TimeFormatterSpec(
//                           format: 'MMM d',
//                           transitionFormat: 'MMM d, y',
//                         ),
//                         month: charts.TimeFormatterSpec(
//                           format: 'MMM y',
//                           transitionFormat: 'MMM y',
//                         ),
//                       ),
//                     ),
//                     primaryMeasureAxis: charts.NumericAxisSpec(
//                       tickProviderSpec: charts.BasicNumericTickProviderSpec(
//                         desiredTickCount: 5,
//                       ),
//                       renderSpec: charts.GridlineRendererSpec(
//                         labelStyle: charts.TextStyleSpec(
//                           fontSize: 14,

//                           // color: Colors.grey,
//                         ),
//                         lineStyle: charts.LineStyleSpec(
//                           dashPattern: [4, 4],
//                           // color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ]),
//         ),
//       ),
//     );
//   }

//   void signUserOut() {
//     FirebaseAuth.instance.signOut();
//   }
// }

// class _ChartData {
//   final DateTime time;
//   final int count;

//   _ChartData(this.time, this.count);
// }
