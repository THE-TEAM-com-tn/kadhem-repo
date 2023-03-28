import 'package:flutter/material.dart';
import 'package:team_elearny/product_details_page/core/models/training_model.dart';

class TrainingGridItem extends StatelessWidget {
  final Training training;
  const TrainingGridItem({Key? key, required this.training}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("##### Image URL: ${training.image}");
    return Card(
      color: Color.fromARGB(255, 83, 83, 83),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.network(training.image, fit: BoxFit.cover)
                ),
                Positioned(
                  bottom: 10.0,
                  left: 10.0,
                  right: 10.0,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Text(
                          training.category.join(" - "),
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Color.fromARGB(255, 194, 159, 147))
                        ),
                        Text(
                          training.title,
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Color.fromARGB(255, 209, 209, 209))
                        ),
                      ],
                    )
                  )
                )
              ]
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () => print("Open is Pressed"),
                child: const Text("Open"),
              ),
              TextButton(
                onPressed: () => print("Delete is Pressed"),
                child: const Text("Delete"),
              )
            ]
          )
        ]
      ),
    );

    // return GFCard(
    //   boxFit: BoxFit.cover,
    //   image: Image.asset("card-cover.avif"),
    //   title: GFListTile(
    //     // avatar: GFAvatar(
    //     //   backgroundImage: AssetImage("card-cover.avif"),
    //     // ),
    //     title: Text('Title'),
    //     subTitle: Text('Sub Title'),
    //   ),
    //   content: Text("Some quick example text to build on the card"),
    //   buttonBar: GFButtonBar(
    //     children: <Widget>[
    //       GFButton(
    //         onPressed: () {},
    //         text: 'OK',
    //       ),
    //       GFButton(
    //         onPressed: () {},
    //         text: 'Cancel',
    //       ),
    //     ],
    //   ),
    // );
  }
}