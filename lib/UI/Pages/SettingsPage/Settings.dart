
import 'package:elearning_provider/UI/Pages/EditProfilePage/EditProfilePage.dart';
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
        const SizedBox(height: 60,),
        ElevatedButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditProfilePage()));
        }, child: const Text("Edit Profile Page")),
        ElevatedButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChangePasswordPage()));
        }, child: const Text("Change Password Page")),
      ]),
    );
  }
}