import 'package:elearning_provider/UI/Pages/ChangePasswodPage/ChangePasswordPage.dart';
import 'package:elearning_provider/UI/Pages/EditProfilePage/EditProfilePage.dart';
import 'package:elearning_provider/UI/Pages/SettingsPage/Settings.dart';
import 'package:elearning_provider/UI/Pages/UsersListPage/users_list_page.dart';
import 'package:elearning_provider/UI/Pages/trainings/list_trainings.dart';
import 'package:elearning_provider/auth/login_or_register_page.dart';
import 'package:elearning_provider/auth/login_page.dart';
import 'package:elearning_provider/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        backgroundColor: const Color(0xFF17282E),
        actions: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 35),
                Expanded(
                  flex: 1,
                  child: userModel.userId != ""
                      ? Image.asset(
                          "lib/images/theteam_light_logo.png",
                          height: 50,
                          width: 50,
                        )
                      : CircularProgressIndicator(),
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
                                return Color(0x4D4B986C);
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
                              builder: (context) => const ListTrainings()));
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
                                return Color(0x4D4B986C);
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
                  child: GestureDetector(
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
                        position:
                            const RelativeRect.fromLTRB(530, 50, 100, 100),
                        items: [
                          PopupMenuItem(
                            value: 'Editprofile',
                            child: SizedBox(
                              height: 45,
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.hovered)) {
                                          // return the color when the button is hovered
                                          return Color(0x4D4B986C);
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
                                                const EditProfilePage()));
                                  },
                                  child: const Text(
                                    'Edit Profile',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'changePassword',
                            child: SizedBox(
                              height: 45,
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.hovered)) {
                                          // return the color when the button is hovered
                                          return const Color(0x4D4B986C);
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
                                                const ChangePasswordPage()));
                                  },
                                  child: const Text(
                                    'Change Password',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'signout',
                            child: SizedBox(
                              height: 45,
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.hovered)) {
                                          // return the color when the button is hovered
                                          return const Color(0x4D4B986C);
                                        }
                                        // return the default color when the button is not hovered
                                        return Colors.transparent;
                                      },
                                    ),
                                  ),
                                  onPressed: () async {

                                    await FirebaseAuth.instance.signOut();
                                    Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>  LoginOrRegisterPage()));
                                  },
                                  child: const Text(
                                    'SignOut',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
