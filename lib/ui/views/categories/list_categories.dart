import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_trainings/core/models/category_model.dart';
import 'package:provider_trainings/core/viewmodels/category_crud_model.dart';
import 'package:provider_trainings/ui/router/app_route_constants.dart';
import 'package:provider_trainings/ui/widgets/category_card.dart';
import 'package:provider/provider.dart';

class ListCategories extends StatefulWidget {
  const ListCategories({super.key});

  @override
  ListCategoriesState createState() => ListCategoriesState();
}

class ListCategoriesState extends State<ListCategories> {
  late List<TrainingCategory> categories;

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryCRUDModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories Management"),
      ),
      body: StreamBuilder(
          stream: categoryProvider.fetchCategoriesAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              categories = snapshot.data!.docs
                  .map((doc) => TrainingCategory.fromJson(
                      doc.data() as Map<String, dynamic>, doc.id))
                  .toList();
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (buildContext, index) =>
                    CategoryCard(category: categories[index]),
              );
            } else {
              return const Text('fetching');
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context)
              .pushNamed(MyAppRouteConstants.addCategoryRouteName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
