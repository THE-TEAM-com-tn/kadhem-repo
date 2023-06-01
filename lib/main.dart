import 'package:provider/provider.dart';
import 'package:theteam_gyp/user-interface/screens/login_screen.dart';
import 'package:theteam_gyp/user-interface/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:theteam_gyp/user-interface/themes/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:theteam_gyp/user-interface/themes/model_theme.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "The TEAM",
            theme: themeNotifier.isDark
                ? ThemeData(
                    brightness: Brightness.dark,
                  )
                : ThemeData(
                    brightness: Brightness.light,
                    primaryColor: Colors.green,
                    primarySwatch: Colors.green),
            home: WelcomeScreen(),
          );
        },
      ),
    );
  }
}
