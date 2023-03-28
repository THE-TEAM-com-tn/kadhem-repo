import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_trainings/core/viewmodels/category_crud_model.dart';
import 'package:provider_trainings/core/viewmodels/tag_crud_model.dart';
import 'package:provider_trainings/firebase_options.dart';
import './ui/router/app_router_config.dart';
import './locator.dart';
import 'core/viewmodels/training_crud_model.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<TrainingCRUDModel>()),
        ChangeNotifierProvider(create: (_) => locator<CategoryCRUDModel>()),
        ChangeNotifierProvider(create: (_) => locator<TagCRUDModel>())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser:
            NyAppRouter.returnRouter().routeInformationParser,
        routerDelegate: NyAppRouter.returnRouter().routerDelegate,
      ),
    );
  }
}
