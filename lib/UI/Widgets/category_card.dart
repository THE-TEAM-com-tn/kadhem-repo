import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/category_model.dart';
import '../../providers/category_crud_model.dart';
import '../Pages/categories/modify_category.dart';

class CategoryCard extends StatelessWidget {
  final TrainingCategory category;
  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryCRUDModel>(context);

    return GestureDetector(
      // when the user tap on a specific category he will be redirected to edit that category page !
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ModifyCategory(category: category)),
        );
      },


      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          child: ListTile(

            leading: Image.network(
              'https://i.imgur.com/z9wpXpa.png',
              height: 200,
            ),

            title: Text("Category Title: ${category.name}"),
            subtitle: Container(
              child: (Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Category Description: ${category.description}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              )),
            ),

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ModifyCategory(category: category),
                      ),
                    );
                  },
                ),


                IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),

                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm'),
                          content: const Text('Are you sure you want to delete this category?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await categoryProvider.removeCategory(category.id!);
                                Navigator.pop(context);
                              //  Navigator.pop(context);
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
                  },


                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
