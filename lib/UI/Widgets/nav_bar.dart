import 'package:elearning_provider/UI/Pages/ChangePasswodPage/ChangePasswordPage.dart';
import 'package:elearning_provider/UI/Pages/EditProfilePage/EditProfilePage.dart';
import 'package:elearning_provider/UI/Pages/SettingsPage/Settings.dart';
import 'package:elearning_provider/UI/Pages/UsersListPage/users_list_page.dart';
import 'package:elearning_provider/UI/Pages/trainings/list_trainings.dart';
import 'package:elearning_provider/UI/Widgets/settings_navigation_rail.dart';
import 'package:elearning_provider/UI/Widgets/trainings_navigation_rail.dart';
import 'package:elearning_provider/auth/home_page.dart';
import 'package:elearning_provider/auth/login_or_register_page.dart';
import 'package:elearning_provider/auth/login_page.dart';
import 'package:elearning_provider/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../providers/EditProfileProvider.dart';

class CustomNavBar extends StatefulWidget {
  final int selectedIndex;
  const CustomNavBar({super.key, required this.selectedIndex});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = widget.selectedIndex;
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        backgroundColor: const Color(0xFF17282E),
        actions: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 35),
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    "lib/images/theteam_light_logo.png",
                    height: 50,
                    width: 50,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 65,
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                // return the color when the button is hovered
                                return const Color(0x4D4B986C);
                              }
                              // return the default color when the button is not hovered
                              return Colors.transparent;
                            },
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SettingsPage()));
                        },
                        child: Text('Home',
                            style: TextStyle(
                                color: _selectedIndex == 0
                                    ? const Color(0xFF4B986C)
                                    : Colors.white))),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 60,
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return const Color(0x4D4B986C);
                              }
                              return Colors.transparent;
                            },
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const TrainingsNavigationRail()));
                        },
                        child: Text('Trainings',
                            style: TextStyle(
                                color: _selectedIndex == 1
                                    ? const Color(0xFF4B986C)
                                    : Colors.white))),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 60,
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                // return the color when the button is hovered
                                return const Color(0x4D4B986C);
                              }
                              // return the default color when the button is not hovered
                              return Colors.transparent;
                            },
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 2;
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const UsersList()));
                        },
                        child: Text(
                          'Users',
                          style: TextStyle(
                              color: _selectedIndex == 2
                                  ? const Color(0xFF4B986C)
                                  : Colors.white),
                        )),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Consumer<EditProfileProvider>(
                      builder: (context, value, child) {
                        if (value.loading) {
                          value.fetchData(
                              FirebaseAuth.instance.currentUser!.uid);
                        }
                        print(
                            "##### nav_bar155 ::: uid: ${FirebaseAuth.instance.currentUser!.uid}");
                        return !value.loading
                            ? GestureDetector(
                                child: CircleAvatar(
                                  radius: 25,
                                  child: ClipOval(
                                    child: Image.network(
                                      userModel.profilePicture,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showMenu(
                                    context: context,
                                    color: const Color(0xFF17282E),
                                    position: const RelativeRect.fromLTRB(
                                        530, 50, 100, 100),
                                    items: [
                                      PopupMenuItem(
                                        value: 'Settings',
                                        child: SizedBox(
                                          height: 45,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .hovered)) {
                                                      // return the color when the button is hovered
                                                      return const Color(
                                                          0x4D4B986C);
                                                    }
                                                    // return the default color when the button is not hovered
                                                    return Colors.transparent;
                                                  },
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const SettingsNavigationRail()));
                                              },
                                              child: const Text(
                                                'Settings',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'My Profile',
                                        child: SizedBox(
                                          height: 45,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .hovered)) {
                                                      // return the color when the button is hovered
                                                      return const Color(
                                                          0x4D4B986C);
                                                    }
                                                    // return the default color when the button is not hovered
                                                    return Colors.transparent;
                                                  },
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()));
                                              },
                                              child: const Text(
                                                'Profile',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'signout',
                                        child: SizedBox(
                                          height: 45,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .hovered)) {
                                                      // return the color when the button is hovered
                                                      return const Color(
                                                          0x4D4B986C);
                                                    }
                                                    // return the default color when the button is not hovered
                                                    return Colors.transparent;
                                                  },
                                                ),
                                              ),
                                              onPressed: () async {
                                                await FirebaseAuth.instance
                                                    .signOut();
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginOrRegisterPage()));
                                              },
                                              child: const Text(
                                                'SignOut',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    child: const CircularProgressIndicator()),
                              );
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
