import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:theteam_gyp/core/dashboard_controller.dart';
import 'package:theteam_gyp/core/models/course_model.dart';
import 'package:theteam_gyp/core/models/training_model.dart';
import 'package:theteam_gyp/user-interface/annimations/animated_switcher_wrapper.dart';
import 'package:theteam_gyp/user-interface/components/cart_training_card.dart';
import 'package:theteam_gyp/user-interface/components/overview_header.dart';
import 'package:theteam_gyp/user-interface/components/product_card.dart';
import 'package:theteam_gyp/user-interface/components/profile_tile.dart';
import 'package:theteam_gyp/user-interface/components/responsive_builder.dart';
import 'package:theteam_gyp/user-interface/components/search_field.dart';
import 'package:theteam_gyp/user-interface/components/selection_button.dart';
import 'package:theteam_gyp/user-interface/components/today_text.dart';
import 'package:theteam_gyp/user-interface/constans/app_constants.dart';
import 'package:theteam_gyp/core/models/profile_model.dart';
import 'package:theteam_gyp/user-interface/screens/EditProfilePage/EditProfilePage.dart';
import 'package:theteam_gyp/user-interface/trainings/expantion_panel.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  DashboardController controller = DashboardController();

  List<TrainingModel> fetchedTrainingsList = [];

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.streamController.add("welcome");
    print("##### Loaded ::: WelcomeScreen ::: Widget");
    return Scaffold(
      key: scaffoldKey,
      drawer: (ResponsiveBuilder.isDesktop(context))
          ? null
          : Drawer(
              child: Padding(
                padding: const EdgeInsets.only(top: kSpacing),
                child: _buildSideBar(),
              ),
            ),
      body: SingleChildScrollView(
          child: ResponsiveBuilder(
        // #####
        // ##### MOBILE CODE SECTION #####
        // #####
        mobileBuilder: (context, constraints) {
          return Column(children: [
            const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
            _buildHeader(onPressedMenu: () => openDrawer()),
            const SizedBox(height: kSpacing / 2),
            const Divider(),
            _buildProfile(),
            const SizedBox(height: kSpacing),
            buildAvaiTrsSection(
              headerAxis: Axis.vertical,
              crossAxisCount: 6,
              crossAxisCellCount: 6,
            ),
          ]);
        },
        // #####
        // ##### TABLET CODE SECTION #####
        // #####
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
                    const SizedBox(height: kSpacing * 2),
                    buildAvaiTrsSection(
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
                    const SizedBox(height: kSpacing),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    const SizedBox(height: kSpacing * (kIsWeb ? 0.5 : 1.5)),
                    // _buildProfile(),
                    const Divider(thickness: 1),
                  ],
                ),
              )
            ],
          );
        },
        // #####
        // ##### DESKTOP CODE SECTION #####
        // #####
        desktopBuilder: (context, constraints) {
          return StreamBuilder<String>(
              stream: controller.streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.data == "welcome") {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // #####
                      // ##### NAVBAR CODE SECTION #####
                      // #####
                      Flexible(
                        flex: (constraints.maxWidth < 1360) ? 4 : 3,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(kBorderRadius),
                              bottomRight: Radius.circular(kBorderRadius),
                            ),
                            child: _buildSideBar()),
                      ),
                      // #####
                      // ##### MAIN CODE SECTION #####
                      // #####
                      Flexible(
                        flex: 9,
                        child: Column(
                          children: [
                            const SizedBox(height: kSpacing),
                            _buildHeader(),
                            const SizedBox(height: kSpacing * 2),
                            buildAvaiTrsSection(
                              crossAxisCount: 6,
                              crossAxisCellCount:
                                  (constraints.maxWidth < 1360) ? 3 : 2,
                            ),
                          ],
                        ),
                      ),
                      // #####
                      // ##### PROFIL CODE SECTION #####
                      // #####
                      Flexible(
                        flex: 4,
                        child: Column(
                          children: [
                            const SizedBox(height: kSpacing / 2),
                            _buildProfile(),
                            const Divider(thickness: 1),
                            const SizedBox(height: kSpacing),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.data == "cart") {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // #####
                      // ##### NAVBAR CODE SECTION #####
                      // #####
                      Flexible(
                        flex: (constraints.maxWidth < 1360) ? 4 : 3,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(kBorderRadius),
                              bottomRight: Radius.circular(kBorderRadius),
                            ),
                            child: _buildSideBar()),
                      ),
                      // #####
                      // ##### MAIN CODE SECTION #####
                      // #####
                      Flexible(
                        flex: 9,
                        child: Column(
                          children: [
                            const SizedBox(height: kSpacing),
                            _buildHeader(),
                            const SizedBox(height: kSpacing * 2),
                            _buildInBasketTrainings()
                          ],
                        ),
                      ),
                      // #####
                      // ##### PROFIL CODE SECTION #####
                      // #####
                      Flexible(
                        flex: 4,
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
                      ),
                    ],
                  );
                } else if (snapshot.data == "profil") {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // #####
                      // ##### NAVBAR CODE SECTION #####
                      // #####
                      Flexible(
                        flex: (constraints.maxWidth < 1360) ? 4 : 3,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(kBorderRadius),
                              bottomRight: Radius.circular(kBorderRadius),
                            ),
                            child: _buildSideBar()),
                      ),
                      // #####
                      // ##### MAIN CODE SECTION #####
                      // #####
                      Flexible(
                        flex: 9,
                        child: Column(
                          children: const [EditProfilePage()],
                        ),
                      ),
                      // #####
                      // ##### PROFIL CODE SECTION #####
                      // #####
                      Flexible(
                        flex: 4,
                        child: Column(
                          children: [
                            const SizedBox(height: kSpacing / 2),
                            _buildProfile(),
                            const Divider(thickness: 1),
                            const SizedBox(height: kSpacing),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.data == "trainings") {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // #####
                      // ##### NAVBAR CODE SECTION #####
                      // #####
                      Flexible(
                        flex: (constraints.maxWidth < 1360) ? 4 : 3,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(kBorderRadius),
                              bottomRight: Radius.circular(kBorderRadius),
                            ),
                            child: _buildSideBar()),
                      ),
                      // #####
                      // ##### MAIN CODE SECTION #####
                      // #####
                      Flexible(
                        flex: 9,
                        child: Column(
                          children: [_buildCourses()],
                        ),
                      ),
                      // #####
                      // ##### PROFIL CODE SECTION #####
                      // #####
                      Flexible(
                        flex: 4,
                        child: Column(
                          children: [
                            const SizedBox(height: kSpacing / 2),
                            _buildProfile(),
                            const Divider(thickness: 1),
                            const SizedBox(height: kSpacing),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              });
        },
      )),
    );
  }

  Widget _buildCourses() {
    return FutureBuilder(
      future: controller.getCourses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 20),
              child: Course(courses: snapshot.data!),
            );
          }
        } else {
          return const CircularProgressIndicator();
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
              "${controller.totalPrice} DT",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                // color: Color(0xFFEC6813),
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

  Widget _buildInBasketTrainings({
    int crossAxisCount = 6,
    int crossAxisCellCount = 2,
    Axis headerAxis = Axis.horizontal,
  }) {
    return FutureBuilder<List<TrainingModel>>(
      future: controller.getTraineesBasket(),
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

  Widget _buildHeader({Function()? onPressedMenu}) {
    Rx<List<TrainingModel>> searchTrainingsResult = Rx([]);
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
          Expanded(
              child: Row(
            children: [
              const TodayText(),
              const SizedBox(width: kSpacing),
              Expanded(child: SearchField(
                onSearch: (input) {
                  searchTrainingsResult.value = fetchedTrainingsList
                      .where((training) =>
                          training.title.toLowerCase().contains(input))
                      .toList();
                },
              )),
            ],
          )),
        ],
      ),
    );
  }

  Widget buildAvaiTrsSection({
    int crossAxisCount = 6,
    int crossAxisCellCount = 2,
    Axis headerAxis = Axis.horizontal,
  }) {
    return FutureBuilder<List<TrainingModel>>(
      future: controller.getTrainingsData(),
      builder:
          (BuildContext context, AsyncSnapshot<List<TrainingModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final trainingData = snapshot.data!;
            fetchedTrainingsList = trainingData;
            Rx<List<TrainingModel>> filteredTrainingsList = Rx(trainingData);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: kSpacing),
                  child: OverviewHeader(
                      axis: headerAxis,
                      onSelected: (trainingCategory) {
                        filteredTrainingsList.value = trainingData
                            .where((training) => training.title
                                .toLowerCase()
                                .contains(trainingCategory))
                            .toList();
                        print("##### $filteredTrainingsList");
                      }),
                ),
                Obx(
                  () => StaggeredGridView.countBuilder(
                    crossAxisCount: crossAxisCount,
                    itemCount: filteredTrainingsList.value.length,
                    addAutomaticKeepAlives: false,
                    padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final data = filteredTrainingsList.value[index];

                      return FutureBuilder<bool>(
                          future: controller.isLoggedIn(),
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            print(
                                "##### welcome_screen ::: Widget buildAvaiTrsSection ::: ${snapshot.data}");
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Firebase Auth state is still loading
                              return const CircularProgressIndicator();
                            } else {
                              if (snapshot.hasData && snapshot.data == true) {
                                // User is logged in
                                return ProductCard(
                                  data: data,
                                  isLogged: true,
                                );
                              } else {
                                // User is not logged in
                                return ProductCard(
                                  data: data,
                                  isLogged: false,
                                );
                              }
                            }
                          });
                    },
                    staggeredTileBuilder: (int index) =>
                        StaggeredTile.fit(crossAxisCellCount),
                  ),
                ),
              ],
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: FutureBuilder<bool>(
        future: controller.isLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> logSnapshot) {
          print(
              "##### welcome_screen ::: Widget _buildProfile ::: ${logSnapshot.data}");
          if (logSnapshot.connectionState == ConnectionState.waiting) {
            // Firebase Auth state is still loading
            return const CircularProgressIndicator();
          } else {
            if (logSnapshot.hasData && logSnapshot.data == true) {
              // User is logged in
              return StreamBuilder<QuerySnapshot<Object?>>(
                stream: controller.getProfile(),
                builder: (context, profileSnapshot) {
                  if (profileSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    // Stream is still loading, show a loading indicator
                    return const CircularProgressIndicator();
                  } else if (profileSnapshot.hasError) {
                    // Error occurred while fetching the data
                    return Text('Error: ${profileSnapshot.error}');
                  } else if (!profileSnapshot.hasData ||
                      profileSnapshot.data!.docs.isEmpty) {
                    // No data found
                    return const Text('No profile documents found');
                  } else {
                    // Data has been successfully received
                    List<ProfileModel> profiles = [];

                    for (var doc in profileSnapshot.data!.docs) {
                      // Access the fields of the document
                      // My User/Profile and the common one are diffrent
                      var name = (doc.data()! as Map)['name'];
                      var email = (doc.data()! as Map)['email'];
                      var photo = (doc.data()! as Map)['photo'];
                      var trainings =
                          (doc.data()! as Map)['inBasket']['trainings'] ?? [];
                      var totalPrice =
                          (doc.data()! as Map)['inBasket']['totalPrice'] ?? 0;

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
                    List<String> castedTrainings =
                        profiles[0].trainings!.cast<String>();
                    print("##### ${castedTrainings}");

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ProfilTile(
                        isLogged: logSnapshot.data!,
                        data: profiles[0],
                        onPressCart: () {
                          controller.streamController.add("cart");
                        },
                      ),
                    );
                  }
                },
              );
            } else {
              // User is not logged in
              return ProfilTile(
                onPressCart: () {},
                isLogged: false,
              );
            }
          }
        },
      ),
    );
  }

  Widget _buildSideBar() {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          const SizedBox(height: kSpacing),
          SelectionButton(
            data: [
              SelectionButtonData(
                activeIcon: EvaIcons.grid,
                icon: EvaIcons.gridOutline,
                label: "Dashboard",
              ),
              SelectionButtonData(
                activeIcon: EvaIcons.book,
                icon: EvaIcons.bookOutline,
                label: "Trainings",
              ),
              SelectionButtonData(
                activeIcon: EvaIcons.settings,
                icon: EvaIcons.settingsOutline,
                label: "Setting",
              ),
            ],
            onSelected: (index, value) {
              if (index == 0) {
                controller.streamController.add("welcome");
              } else if (index == 1) {
                controller.streamController.add("trainings");
              } else {
                controller.streamController.add("profil");
              }
            },
          ),
          const Divider(thickness: 1),
          const SizedBox(height: kSpacing * 2),
        ],
      ),
    );
  }
}
