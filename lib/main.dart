import 'package:elearning_provider/UI/Pages/SettingsPage/Settings.dart';
import 'package:elearning_provider/locator.dart';
import 'package:elearning_provider/providers/EditProfileProvider.dart';
import 'package:elearning_provider/providers/PasswordChangeProvider.dart';
import 'package:elearning_provider/providers/category_crud_model.dart';
import 'package:elearning_provider/providers/tag_crud_model.dart';
import 'package:elearning_provider/providers/training_crud_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

        /*   apiKey: "AIzaSyDoDl0kAnDaVGML615Ozzc4xolyWjmyqMI",
        appId: "1:507597460669:web:1bf866062f2811191453d4",
        messagingSenderId: "507597460669",
        projectId: "firstsprint-e9731",
        storageBucket: "gs://firstsprint-e9731.appspot.com"),*/

void main() async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCxonhqtYbqQLORbx_-c-n2bWN0e-4Km3g',
        appId: '1:906403289387:web:7a1f8902ee9c78fc5a8d6e',
        messagingSenderId: '906403289387',
        projectId: 'fir-cruddemo-2bf79',
       // authDomain: 'fir-cruddemo-2bf79.firebaseapp.com',
        storageBucket: 'fir-cruddemo-2bf79.appspot.com'));
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
        ChangeNotifierProvider(
            create: (_) => locator<PasswordChangeProvider>()),
        ChangeNotifierProvider(create: (_) => locator<TrainingCRUDModel>()),
        ChangeNotifierProvider(create: (_) => locator<CategoryCRUDModel>()),
        ChangeNotifierProvider(create: (_) => locator<TagCRUDModel>())
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
