import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../UI/Pages/lessons/all_lessons_admin_side.dart';
import '../UI/Pages/lessons/user_side_of_all_lessons.dart';
import '../UI/Pages/users/add_many_users_csv_xcel.dart';
import '../UI/Pages/users/add_many_users_json.dart';
import '../UI/Pages/users/add_user.dart';
import '../UI/Widgets/nav_bar.dart';
import 'login_or_register_page.dart';
import 'login_page.dart';
//import 'Mobile_screenshot_blocker.dart';
import 'components/utils.dart';

//import '../user_crud/add_user.dart';
//import '../user_crud/read_users.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    //Utils.enableScreenshotProtection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomNavBar(),
      ),

      /*AppBar(
          OLD APPBAR 
    leading: IconButton(
          icon: const Icon(Icons.account_circle_rounded, color: Colors.white),
          onPressed: () {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfilePage(context),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please Log in!'),
                  duration: Duration(seconds: 4),
                  backgroundColor: Colors.purpleAccent,
                ),
              );
            }
          },
        ),
        title: Center(
          child: Text(
            user.email!,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],


      ),*/

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  // Use the user's profile picture URL as the image source
                  image: NetworkImage(
                      user.photoURL ?? 'https://i.imgur.com/a73xXCl.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              "Logged in As: ${user.email}",
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Add user",
                  style: TextStyle(
                      fontSize: 14, color: CupertinoColors.activeBlue),
                ),
                const SizedBox(height: 10),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddUserPage(),
                      ),
                    );
                  },
                  icon: Ink.image(
                    image:
                        const NetworkImage("https://i.imgur.com/FRlZP2p.png"),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadUsersPage(),
                  ),
                );*/
              },
              child: const Text('View All users page'),
            ),

            // const SizedBox(height: 15),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                /*      Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MobileScreenshotBlockerPage(
                      onSecureModeChanged: () {},
                    ),
                  ),
                );*/
              },
              child: const Text('Go to Mobile Screenshot Blocker Page'),
            ),

            const SizedBox(height: 15),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddManyUsersPage(),
                      ),
                    );
                  },
                  icon: Ink.image(
                    image: const AssetImage("lib/images/img-csv.png"),
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddUsersFromJsonPage(),
                      ),
                    );
                  },
                  icon: Ink.image(
                    image: const AssetImage("lib/images/img-json.png"),
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),

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


          ],
        ),
      ),
    );
  }
}

class MobileScreenshotBlockerPage extends StatelessWidget {
  final VoidCallback onSecureModeChanged;

  MobileScreenshotBlockerPage({required this.onSecureModeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Screenshot Blocker'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: const Center(
          // child: MobileScreenshotBlocker(onSecureModeChanged: onSecureModeChanged),
          ),
    );
  }
}