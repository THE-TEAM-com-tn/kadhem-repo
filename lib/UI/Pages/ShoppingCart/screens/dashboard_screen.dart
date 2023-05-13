import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:elearning_provider/UI/Pages/ShoppingCart/components/search_field.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import '../../../../models/training_model.dart';
// import 'package:project_management/app/shared_components/chatting_card.dart';
import '../components/responsive_builder.dart';
// import 'package:project_management/app/shared_components/project_card.dart';
// import './components/search_field.dart';
// import './components/selection_button.dart';
import '../components/training_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../components/profile_tile.dart';

// models
import '../../../../models/profile_model.dart';

// controller
import '../controllers/dashboard_controller.dart';

// component
// import './components/active_project_card.dart';
import '../components/header.dart';
// import './components/overview_header.dart';

// import './components/recent_messages.dart';
// import './components/sidebar.dart';
// import './components/team_member.dart';

class DashboardScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DashboardScreen({Key? key});

  DashboardController controller = DashboardController();

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(60, 10, 10, 10),
      key: scaffoldKey,
      drawer: (ResponsiveBuilder.isDesktop(context))
          ? null
          : const Drawer(
              child: Padding(
                //kSpacing
                padding: EdgeInsets.only(top: 20.0),
                child:
                    Placeholder() /*Sidebar(data: controller.getSelectedProject())*/,
              ),
            ),
      body: SingleChildScrollView(
          child: ResponsiveBuilder(
        mobileBuilder: (context, constraints) {
          return Column(children: [
            const SizedBox(height: 20.0 * (kIsWeb ? 1 : 2)),
            _buildHeader(onPressedMenu: () => openDrawer()),
            const SizedBox(height: 20.0 / 2),
            const Divider(),
            _buildProfile(),
            const SizedBox(height: 20.0),
            _buildTrainingOverview(
                headerAxis: Axis.vertical,
                crossAxisCount: 6,
                crossAxisCellCount: 6,
                controller: controller),
            const SizedBox(height: 20.0 * 2),
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
                    const SizedBox(height: 20.0 * (kIsWeb ? 1 : 2)),
                    _buildHeader(onPressedMenu: () => openDrawer()),
                    const SizedBox(height: 20.0 * 2),
                    _buildTrainingOverview(
                        headerAxis: (constraints.maxWidth < 850)
                            ? Axis.vertical
                            : Axis.horizontal,
                        crossAxisCount: 6,
                        crossAxisCellCount: (constraints.maxWidth < 950)
                            ? 6
                            : (constraints.maxWidth < 1100)
                                ? 3
                                : 2,
                        controller: controller),
                    const SizedBox(height: 20.0 * 2),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0 * (kIsWeb ? 0.5 : 1.5)),
                    _buildProfile(),
                    const Divider(thickness: 1),
                    const SizedBox(height: 20.0),
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
              Flexible(
                flex: (constraints.maxWidth < 1360) ? 4 : 3,
                child: const ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    child:
                        Placeholder() /*Sidebar(data: controller.getSelectedProject())*/),
              ),
              Flexible(
                flex: 9,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    _buildHeader(),
                    const SizedBox(height: 20.0 * 2),
                    _buildTrainingOverview(
                        crossAxisCount: 6,
                        crossAxisCellCount:
                            (constraints.maxWidth < 1360) ? 3 : 2,
                        controller: controller),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0 / 2),
                    _buildProfile(),
                    const Divider(thickness: 1),
                    const SizedBox(height: 20.0),
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          if (onPressedMenu != null)
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
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

  Widget _buildTrainingOverview(
      {int crossAxisCount = 6,
      int crossAxisCellCount = 2,
      Axis headerAxis = Axis.horizontal,
      controller}) {
    return FutureBuilder<List<Training>>(
      future: controller.getTrainingData(),
      builder: (BuildContext context, AsyncSnapshot<List<Training>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final trainingData = snapshot.data!;

            return StaggeredGridView.countBuilder(
              crossAxisCount: crossAxisCount,
              itemCount: trainingData.length,
              addAutomaticKeepAlives: false,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final data = trainingData[index];

                return TrainingCard(
                  data: data,
                  onPressedMore: () {
                    // Get.toNamed(AppPages.trainingDetails,
                    //     arguments: {'trainingData': data});
                  },
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
            // My User/Profile and the common one are diffrent
            var name = (doc.data()! as Map)['lastName'];
            var email = (doc.data()! as Map)['email'];
            var photo = (doc.data()! as Map)['profile_picture'];
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
          List<String> castedTrainings = profiles[0].trainings!.cast<String>();
          print("##### ${castedTrainings}");

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ProfilTile(
              data: profiles[0],
              onPressed: () {
                // var profiles[0].trainings;
                print(
                    "##### dashboard_screen.dart => onPressed() => ProfilTile => _buildProfile() ::: ${profiles[0].trainings}");
                print(
                    "##### dashboard_screen.dart => onPressed() => ProfilTile => _buildProfile() ::: ${profiles[0].totalPrice}");
                // Get.toNamed(AppPages.cart, arguments: {
                //   'trainings': castedTrainings,
                //   "totalPrice": profiles[0].totalPrice
                // });
              },
            ),
          );
        }
      },
    );
  }
}
