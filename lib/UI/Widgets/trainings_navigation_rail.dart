import 'package:elearning_provider/UI/Pages/categories/list_categories.dart';
import 'package:elearning_provider/UI/Pages/tags/list_tags.dart';
import 'package:elearning_provider/UI/Pages/trainings/list_trainings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'nav_bar.dart';

class TrainingsNavigationRail extends StatefulWidget {
  const TrainingsNavigationRail({super.key});

  @override
  State<TrainingsNavigationRail> createState() =>
      _TrainingsNavigationRailState();
}

class _TrainingsNavigationRailState extends State<TrainingsNavigationRail> {
  static const List<Widget> destinations = [
    ListTrainings(),
    ListTags(),
    ListCategories()
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomNavBar(selectedIndex: 1,),
      ),
      body: Row(
        children: <Widget>[
        MediaQuery.of(context).size.height > 660 ?  NavigationRail(
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
                icon: Icon(Icons.book_online_outlined),
                selectedIcon: Icon(Icons.favorite),
                label: Text('Trainings'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.book),
                label: Text('Tags'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.category_outlined),
                selectedIcon: Icon(Icons.star),
                label: Text('Categories'),
              ),
            ],
            groupAlignment: 0.0,
            selectedIconTheme: const IconThemeData(color: Color.fromARGB(77, 50, 216, 122)),
            unselectedIconTheme: const IconThemeData(color: Colors.white),
          ) : Container(),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(child: destinations[_selectedIndex])
        ],
      ),
    );
  }
}
