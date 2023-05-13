import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearning_provider/UI/Pages/ShoppingCart/components/header.dart';
import 'package:elearning_provider/UI/Pages/ShoppingCart/components/profile_tile.dart';
import 'package:elearning_provider/UI/Pages/ShoppingCart/components/responsive_builder.dart';
import 'package:elearning_provider/UI/Pages/ShoppingCart/components/sidebar.dart';
import 'package:elearning_provider/UI/Pages/ShoppingCart/components/training_details_card.dart';
import 'package:elearning_provider/UI/Pages/ShoppingCart/constans/app_constants.dart';
import 'package:elearning_provider/UI/Pages/ShoppingCart/controllers/training_details_controller.dart';
import 'package:elearning_provider/models/profile_model.dart';
import 'package:elearning_provider/models/training_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TrainingDetailsScreen extends StatelessWidget {
  final Training training;
  final userID;
  TrainingDetailsScreen(
      {Key? key, required this.training, required this.userID});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  TrainingDetailsController controller = TrainingDetailsController();

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalBackground,
      key: scaffoldKey,
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
            _buildTrainingCard(axis: Axis.vertical),
            const SizedBox(height: kSpacing)
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
                    _buildTrainingCard(),
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
              //       child: Sidebar(data: controller.getSelectedProject())),
              // ),
              Flexible(
                flex: 9,
                child: Column(
                  children: [
                    const SizedBox(height: kSpacing),
                    _buildHeader(),
                    const SizedBox(height: kSpacing),
                    _buildTrainingCard(),
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

  Widget _buildTrainingCard({Axis axis = Axis.horizontal}) {
    // final trainingData = controller.getTrainingDetails();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: (axis == Axis.horizontal)
          ? Row(
              children: [
                Flexible(
                  flex: 9,
                  child: TrainingDetailsCard(
                    userID: userID,
                    data: training,
                  ),
                )
              ],
            )
          : Column(
              children: [
                TrainingDetailsCard(
                  userID: userID,
                  data: training,
                )
              ],
            ),
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
            var name = (doc.data()! as Map)['lastName'];
            var email = (doc.data()! as Map)['email'];
            var photo = (doc.data()! as Map)['profile_picture'];
            var trainings = (doc.data()! as Map)['inBasket']['trainings'];
            var totalPrice = (doc.data()! as Map)['inBasket']['totalPrice'];

            // Create a ProfileModel instance using the retrieved fields
            var profileModel = ProfileModel(
              id: userID,
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
                data: profiles[0],
                onPressCart: () {
                  // Get.toNamed(AppPages.cart);
                }),
          );
        }
      },
    );
  }
}
