import 'package:theteam_gyp/user-interface/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:theteam_gyp/user-interface/themes/app_theme.dart';

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
      title: "The TEAM",
      theme: AppTheme.basic,
      home: WelcomeScreen(),
    );
  }
}
