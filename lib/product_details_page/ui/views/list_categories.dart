import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/models/category_model.dart';
import '../../core/viewmodels/category_crud_model.dart';
import '../../ui/widgets/category_card.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_category');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Categories Management"),
      ),
      body: StreamBuilder(
          stream: categoryProvider.fetchCategoriesAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              categories = snapshot.data!.docs
              .map((doc) => TrainingCategory.fromJson(doc.data() as Map<String, dynamic>, doc.id))
              .toList();
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (buildContext, index) => CategoryCard(category: categories[index]),
              );
            } else {
              return const Text('fetching');
            }
          }),
    );
  }
}
