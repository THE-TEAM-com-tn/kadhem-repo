import 'package:elearny_shopping_cart/cart_model.dart';
import 'package:elearny_shopping_cart/cart_provider.dart';
import 'package:elearny_shopping_cart/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DBHelper dbHelper = DBHelper();

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
    "assets/images/organic-apples.png",
    "assets/images/whole-grain-bread.png",
    "assets/images/organic-brown-rice.png",
    "assets/images/free-range-eggs.png",
    "assets/images/grass-fed-beef.png",
    "assets/images/wild-cought-salmon.png",
    "assets/images/organic-spinach.png",
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        centerTitle: true,
        actions: [
          Center(
            child: badges.Badge(
              badgeContent: Consumer(builder: (context, value, child) {
                return const Text('0', style: TextStyle(color: Colors.white));
              }),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
          const SizedBox(width: 20),
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
                          image: AssetImage(productImage[index]),
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
                                child: InkWell(
                                  onTap: () {
                                    dbHelper
                                        .insert(Cart(
                                            id: index,
                                            productId: index.toString(),
                                            productName: productName[index],
                                            initialPrice: productPrice[index],
                                            productPrice: productPrice[index],
                                            quantity: 1,
                                            unitTag: productUnit[index],
                                            image: productImage[index]))
                                        .then((value) => {
                                              print(
                                                  "#####  ${productName[index]} added to cart."),
                                              cart.addTotalPrice(
                                                  productPrice[index]),
                                              cart.addCounter()
                                            })
                                        .onError((error, stackTrace) =>
                                            {print("#####  $error")});
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "Add To Cart",
                                        style: TextStyle(color: Colors.white),
                                      ),
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
