//import 'package:elearning_provider/UI/Pages/EditProfilePage/EditProfilePage.dart';
import 'package:elearning_provider/UI/Pages/UsersListPage/users_list_page.dart';
import 'package:elearning_provider/UI/Pages/categories/list_categories.dart';
import 'package:elearning_provider/UI/Pages/tags/list_tags.dart';
import 'package:elearning_provider/UI/Pages/trainings/list_trainings.dart';
import 'package:elearning_provider/auth/home_page.dart';
//import 'package:elearning_provider/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../ChangePasswodPage/ChangePasswordPage.dart';
import '../EditProfilePage/EditProfilePage.dart';
import '../lessons/all_lessons_admin_side.dart';
import '../lessons/user_side_of_all_lessons.dart';
import '../users/list_users.dart';

class SettingsPage extends StatelessWidget {
  final String? userId;
  SettingsPage({Key? key, this.userId})
      : super(key: key); //required UserModel userModel

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.deepPurple[200], // Set the background color to deep purple
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.account_box, color: Colors.white),
          onPressed: () {
            // This Icon button will redirect you to the user profile page or User's Settings Page !
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(), // userId: userId
              ),
            );
          },
        ),

        title: const Center(
          child: Text(
            "welcome",
            //user.email!, // this will display the user email in the app bar
            style: TextStyle(fontSize: 16),
          ),
        ),

        actions: [
          TextButton.icon(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('User ID: $userId'),
          const SizedBox(height: 6),
          const Text(
            "This is the Weclome/Home Page , these buttons will be on the Side NavBar",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditProfilePage()));
              },
              child: const Text("Edit Profile Page")),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChangePasswordPage()));
              },
              child: const Text("Change Password Page")),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ListTags()));
              },
              child: const Text("Tags page")),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ListCategories()));
              },
              child: const Text("Categories page")),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ListTrainings()));
              },
              child: const Text("Trainings page")),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: const Text("HomePage / User Profile")),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                /* ListUsers();*/
                print("this button does nothing");
              },
              child: const Text("Button Sample")),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const UsersList()));
              },
              child: const Text("Users List")),
              SizedBox(height: 15,),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: const Text("Add Users")),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllLessons(),
                ),
              );
            },
            child: const Text('View All Lessons Admin side'),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrangeAccent,),
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyLessonsPage(),
                ),
              );
            },
            child: const Text('View All Lessons User side'),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrangeAccent,),
          ),



        ]),
      ),
    );
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
}
