import 'package:elearning_provider/UI/Pages/SettingsPage/Settings.dart';
import 'package:elearning_provider/locator.dart';
import 'package:elearning_provider/providers/EditProfileProvider.dart';
import 'package:elearning_provider/providers/PasswordChangeProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  await Firebase.initializeApp(
      options:  const FirebaseOptions(
          apiKey: "AIzaSyDoDl0kAnDaVGML615Ozzc4xolyWjmyqMI",
          appId: "1:507597460669:web:1bf866062f2811191453d4",
          messagingSenderId: "507597460669",
          projectId: "firstsprint-e9731",
          storageBucket: "gs://firstsprint-e9731.appspot.com") ,);
  runApp(const MyApp());
  setupLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // add providers to make it available everywhere
      providers: [
         ChangeNotifierProvider(create: (_) => locator<EditProfileProvider>()),
         ChangeNotifierProvider(create: (_) => locator<PasswordChangeProvider>()) 
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SettingsPage(),
      ),
    );
  }
}

