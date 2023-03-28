import 'package:flutter/material.dart';
import 'package:team_elearny/index.dart';
import 'package:team_elearny/product_details_page/ui/views/add_category.dart';
import 'package:team_elearny/product_details_page/ui/views/add_tag.dart';
import 'package:team_elearny/product_details_page/ui/views/add_training.dart';
import 'package:team_elearny/product_details_page/ui/views/home_view.dart';
import 'package:team_elearny/product_details_page/ui/views/list_categories.dart';
import 'package:team_elearny/product_details_page/ui/views/list_tags.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeView());

      case '/add_training':
        return MaterialPageRoute(builder: (_) => const AddTraining());

      case '/add_category':
        return MaterialPageRoute(builder: (_) => const AddCategory());

      case '/add_tag':
        return MaterialPageRoute(builder: (_) => const AddTag());

      case '/list_categories':
        return MaterialPageRoute(builder: (_) => const ListCategories());

      case '/list_trainings':
        return MaterialPageRoute(builder: (_) => const ListTrainings());

      case '/list_tags':
        return MaterialPageRoute(builder: (_) => const ListTags());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}
