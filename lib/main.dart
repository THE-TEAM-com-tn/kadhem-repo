import 'package:theteam_gyp/admin-interface/AdminDashboardPage.dart';
import 'package:theteam_gyp/user-interface/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'T-Learny',
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/admins': (context) => DashboardAdminSummaryWidget(),
      },
    );
  }
}
