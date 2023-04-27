import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<String> productName = [
    "Organic Apples",
    "Whole Grain Bread",
    "Organic Brown Rice",
    "Free-Range Eggs",
    "Grass-Fed Beef",
    "Wild-Caught Salmon",
    "Organic Spinach"
  ];

  List<double> productPrice = [2.99, 3.49, 4.99, 2.79, 12.99, 9.99, 1.99];

  List<String> productUnit = ["lb", "loaf", "lb", "dozen", "lb", "lb", "bunch"];

  List<String> productImage = [
    "https://dummyimage.com/300x200/000/fff&text=Product+1",
    "https://dummyimage.com/300x200/000/fff&text=Product+2",
    "https://dummyimage.com/300x200/000/fff&text=Product+3",
    "https://dummyimage.com/300x200/000/fff&text=Product+4",
    "https://dummyimage.com/300x200/000/fff&text=Product+5",
    "https://dummyimage.com/300x200/000/fff&text=Product+6",
    "https://dummyimage.com/300x200/000/fff&text=Product+7"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        centerTitle: true,
        actions: const [
          Center(
            child: badges.Badge(
              badgeContent: Text(
                '0',
                style: TextStyle(color: Colors.white),
              ),
              child: Icon(Icons.shopping_bag_outlined),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
          itemCount: productName.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image(
                          height: 100,
                          width: 100,
                          image: NetworkImage(productImage[index]),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productName[index],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                productUnit[index] +
                                    " " +
                                    r"$" +
                                    productPrice[index].toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: 35,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                    child: Text(
                                      "Add To Cart",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ))
      ]),
    );
  }
}
