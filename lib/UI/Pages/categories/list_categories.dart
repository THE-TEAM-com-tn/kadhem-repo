import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearning_provider/UI/Pages/categories/add_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/category_model.dart';
import '../../../providers/category_crud_model.dart';
import '../../Widgets/category_card.dart';
import '../../Widgets/nav_bar.dart';

class ListCategories extends StatefulWidget {
  const ListCategories({super.key});
  //const ListCategories();

  @override
  ListCategoriesState createState() => ListCategoriesState();
}

class ListCategoriesState extends State<ListCategories> {
  late List<TrainingCategory> categories;

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryCRUDModel>(context);

    return Scaffold(
      /*actions: [

          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddCategory()));
            },

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                'https://i.imgur.com/nVdbYE8.png',
                height: 32,
                width: 32,
              ),
            ),
          ),

        ],*/

      body: Consumer<CategoryCRUDModel>(
        builder: (context, value, child) {
          var size = MediaQuery.of(context).size;
          final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
          final double itemWidth = size.width / 2;
          if (value.loadingCategories) {
            value.getAllCategories();
          }
          return !value.loadingCategories
              ? Column(
                  children: [
                      ElevatedButton(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => AddCategory()).then((val) {
                                setState(() {
                                  value.loadingCategories = true ; 
                                });
                              });
                          setState(() {
                            value.loadingCategories;
                          });
                        },
                        child: Text('Add Category')),
                     Expanded(
                          child: MediaQuery.of(context).size.width > 600
                        ? GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: itemWidth / itemHeight,
                                      crossAxisCount: 2),
                              itemCount: value.allCategories.length,
                              itemBuilder: (buildContext, index) => CategoryCard(
                                  category: value.allCategories[index], provider: value,),
                            )                         : ListView.builder(
                            itemCount: value.allCategories.length,
                            itemBuilder: (buildContext, index) => CategoryCard(
                                category: value.allCategories[index], provider: value,),
                          ),
                        )

                  ],
                )
              : CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddCategory()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/* StreamBuilder(
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
              return const Text('Fetching...');
            }

          }),*/
