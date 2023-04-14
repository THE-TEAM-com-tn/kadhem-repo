import 'package:elearning_provider/UI/Pages/EditProfilePage/EditProfilePage.dart';
import 'package:elearning_provider/UI/Pages/categories/list_categories.dart';
import 'package:elearning_provider/UI/Pages/tags/list_tags.dart';
import 'package:elearning_provider/UI/Pages/trainings/list_trainings.dart';
import 'package:elearning_provider/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../ChangePasswodPage/ChangePasswordPage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings Page"),
      ),
      body: Row(children: [
        const SizedBox(
          height: 60,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EditProfilePage()));
            },
            child: const Text("Edit Profile Page")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ChangePasswordPage()));
            },
            child: const Text("Change Password Page")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ListTags()));
            },
            child: const Text("Tags page")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ListCategories()));
            },
            child: const Text("Categories page")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ListTrainings()));
            },
            child: const Text("Trainings page")),
        ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut() ;
            },
            child: const Text("Sign Out")),
      ]),
    );
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
}
