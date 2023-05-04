import 'package:elearning_provider/UI/Pages/ChangePasswodPage/ChangePasswordPage.dart';
import 'package:elearning_provider/UI/Pages/EditProfilePage/EditProfilePage.dart';
import 'package:elearning_provider/UI/Pages/categories/list_categories.dart';
import 'package:elearning_provider/UI/Pages/tags/list_tags.dart';
import 'package:elearning_provider/UI/Pages/trainings/list_trainings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'nav_bar.dart';

class SettingsNavigationRail extends StatefulWidget {
  const SettingsNavigationRail({super.key});

  @override
  State<SettingsNavigationRail> createState() =>
      _SettingsNavigationRailState();
}

class _SettingsNavigationRailState extends State<SettingsNavigationRail> {
  static const List<Widget> destinations = [
    EditProfilePage(),
    ChangePasswordPage()
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomNavBar(selectedIndex: 3),
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            backgroundColor: const Color(0xFF17282E) ,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            selectedLabelTextStyle: TextStyle(color: Color(0x4D4B986C)),
            unselectedLabelTextStyle: TextStyle(color: Colors.white),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.edit_attributes_outlined),
                selectedIcon: Icon(Icons.edit_attributes),
                label: Text('Edit Profile'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.password_outlined),
                selectedIcon: Icon(Icons.password),
                label: Text('Change Password'),
              ),
            ],
            groupAlignment: 0.0,
            selectedIconTheme: const IconThemeData(color: Color.fromARGB(77, 50, 216, 122)),
            unselectedIconTheme: const IconThemeData(color: Colors.white),
          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(child: destinations[_selectedIndex])
        ],
      ),
    );
  }
}
