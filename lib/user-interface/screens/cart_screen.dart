import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:theteam_gyp/core/dashboard_controller.dart';
import 'package:theteam_gyp/core/models/profile_model.dart';
import 'package:theteam_gyp/core/models/training_model.dart';
import 'package:theteam_gyp/user-interface/annimations/animated_switcher_wrapper.dart';
import 'package:theteam_gyp/user-interface/components/cart_training_card.dart';
import 'package:theteam_gyp/user-interface/components/header.dart';
import 'package:theteam_gyp/user-interface/components/profile_tile.dart';
import 'package:theteam_gyp/user-interface/components/responsive_builder.dart';
import 'package:theteam_gyp/user-interface/constans/app_constants.dart';

class CartScreen extends StatelessWidget {
  final List<dynamic> trainingsIDs;
  final double? totalPrice;
  final bool isLogged;

  CartScreen(
      {Key? key,
      required this.trainingsIDs,
      required this.totalPrice,
      required this.isLogged})
      : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  DashboardController controller = DashboardController();

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.streamController.add("cart");
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: globalBackground,
      // drawer: (ResponsiveBuilder.isDesktop(context))
      //     ? null
      //     : Drawer(
      //         child: Padding(
      //           padding: const EdgeInsets.only(top: kSpacing),
      //           child: Sidebar(data: controller.getSelectedProject()),
      //         ),
      //       ),
      body: SingleChildScrollView(
          child: ResponsiveBuilder(
        mobileBuilder: (context, constraints) {
          return Column(children: [
            const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
            _buildHeader(onPressedMenu: () => openDrawer()),
            const SizedBox(height: kSpacing / 2),
            const Divider(),
            _buildProfile(),
            const SizedBox(height: kSpacing * 2),
            _buildInBasketTrainings(
              headerAxis: Axis.vertical,
              crossAxisCount: 6,
              crossAxisCellCount: 6,
            ),
            const SizedBox(height: kSpacing),
            bottomBarTitle(),
            bottomBarButton(),
          ]);
        },
        tabletBuilder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: (constraints.maxWidth < 950) ? 6 : 9,
                child: Column(
                  children: [
                    const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
                    _buildHeader(onPressedMenu: () => openDrawer()),
                    const SizedBox(height: kSpacing),
                    _buildInBasketTrainings(
                      headerAxis: (constraints.maxWidth < 850)
                          ? Axis.vertical
                          : Axis.horizontal,
                      crossAxisCount: 6,
                      crossAxisCellCount: (constraints.maxWidth < 950)
                          ? 6
                          : (constraints.maxWidth < 1100)
                              ? 3
                              : 2,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    const SizedBox(height: kSpacing * (kIsWeb ? 0.5 : 1.5)),
                    _buildProfile(),
                    const Divider(thickness: 1),
                    bottomBarTitle(),
                    bottomBarButton(),
                    const SizedBox(height: kSpacing),
                  ],
                ),
              )
            ],
          );
        },
        desktopBuilder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Flexible(
              //   flex: (constraints.maxWidth < 1360) ? 4 : 3,
              //   child: ClipRRect(
              //       borderRadius: const BorderRadius.only(
              //         topRight: Radius.circular(kBorderRadius),
              //         bottomRight: Radius.circular(kBorderRadius),
              //       ),
              //       child: _Sidebar(data: controller.getSelectedProject())),
              // ),
              Flexible(
                flex: 9,
                child: Column(
                  children: [
                    const SizedBox(height: kSpacing),
                    _buildHeader(),
                    const SizedBox(height: kSpacing),
                    _buildInBasketTrainings(
                      crossAxisCount: 6,
                      crossAxisCellCount: (constraints.maxWidth < 1360) ? 3 : 2,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    const SizedBox(height: kSpacing / 2),
                    _buildProfile(),
                    const Divider(thickness: 1),
                    bottomBarTitle(),
                    bottomBarButton(),
                    const SizedBox(height: kSpacing),
                  ],
                ),
              )
            ],
          );
        },
      )),
    );
  }

  Widget _buildHeader({Function()? onPressedMenu}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        children: [
          if (onPressedMenu != null)
            Padding(
              padding: const EdgeInsets.only(right: kSpacing),
              child: IconButton(
                onPressed: onPressedMenu,
                icon: const Icon(EvaIcons.menu),
                tooltip: "menu",
              ),
            ),
          const Expanded(child: Header()),
        ],
      ),
    );
  }

  Widget _buildInBasketTrainings({
    int crossAxisCount = 6,
    int crossAxisCellCount = 2,
    Axis headerAxis = Axis.horizontal,
  }) {
    return FutureBuilder<List<TrainingModel>>(
      future: null,
      builder:
          (BuildContext context, AsyncSnapshot<List<TrainingModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final trainings = snapshot.data!;

            return StaggeredGridView.countBuilder(
              crossAxisCount: crossAxisCount,
              itemCount: trainings.length,
              addAutomaticKeepAlives: false,
              padding: const EdgeInsets.symmetric(horizontal: kSpacing),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final data = trainings[index];

                return CartTrainingCard(
                  data: data,
                  onPressedMore: () {},
                  onPressedTask: () {},
                  onPressedContributors: () {},
                  onPressedComments: () {},
                );
              },
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.fit(crossAxisCellCount),
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildProfile() {
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: controller.getProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Stream is still loading, show a loading indicator
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Error occurred while fetching the data
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          // No data found
          return const Text('No profile documents found');
        } else {
          // Data has been successfully received
          List<ProfileModel> profiles = [];

          for (var doc in snapshot.data!.docs) {
            // Access the fields of the document
            var name = (doc.data()! as Map)['name'];
            var email = (doc.data()! as Map)['email'];
            var photo = (doc.data()! as Map)['photo'];
            var trainings = (doc.data()! as Map)['inBasket']['trainings'];
            var totalPrice = (doc.data()! as Map)['inBasket']['totalPrice'];

            // Create a ProfileModel instance using the retrieved fields
            var profileModel = ProfileModel(
              name: name,
              email: email,
              photo: photo,
              trainings: trainings,
              totalPrice: totalPrice,
            );

            // Add the profileModel to the list
            profiles.add(profileModel);
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpacing),
            child: ProfilTile(
                isLogged: true,
                data: profiles[0],
                onPressCart: () {
                  // Get.toNamed(AppPages.cart);
                }),
          );
        }
      },
    );
  }

  Widget bottomBarTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          AnimatedSwitcherWrapper(
            child: Text(
              "$totalPrice DT",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Color(0xFFEC6813),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomBarButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
          onPressed: () {},
          child: const Text("Buy Now"),
        ),
      ),
    );
  }
}
