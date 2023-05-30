import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:theteam_gyp/core/dashboard_controller.dart';
import 'package:theteam_gyp/core/models/training_model.dart';
import 'package:theteam_gyp/user-interface/components/active_project_card.dart';
import 'package:theteam_gyp/user-interface/components/cart_training_card.dart';
import 'package:theteam_gyp/user-interface/components/chatting_card.dart';
import 'package:theteam_gyp/user-interface/components/get_premium_card.dart';
import 'package:theteam_gyp/user-interface/components/list_profil_image.dart';
import 'package:theteam_gyp/user-interface/components/overview_header.dart';
import 'package:theteam_gyp/user-interface/components/product_card.dart';
import 'package:theteam_gyp/user-interface/components/profile_tile.dart';
import 'package:theteam_gyp/user-interface/components/progress_card.dart';
import 'package:theteam_gyp/user-interface/components/project_card.dart';
import 'package:theteam_gyp/user-interface/components/recent_messages.dart';
import 'package:theteam_gyp/user-interface/components/responsive_builder.dart';
import 'package:theteam_gyp/user-interface/components/search_field.dart';
import 'package:theteam_gyp/user-interface/components/sidebar.dart';
import 'package:theteam_gyp/user-interface/components/team_member.dart';
import 'package:theteam_gyp/user-interface/components/today_text.dart';
import 'package:theteam_gyp/user-interface/constans/app_constants.dart';
import 'package:theteam_gyp/core/models/profile_model.dart';
import 'package:theteam_gyp/user-interface/screens/cart_screen.dart';

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
                child: Sidebar(data: controller.getSelectedProject()),
              ),
            ),
      body: SingleChildScrollView(
          child: ResponsiveBuilder(
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
                    _buildProgress(
                      axis: (constraints.maxWidth < 950)
                          ? Axis.vertical
                          : Axis.horizontal,
                    ),
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
                    const SizedBox(height: kSpacing * 2),
                    _buildActiveProject(
                      data: controller.getActiveProject(),
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
                    _buildProfile(),
                    const Divider(thickness: 1),
                    const SizedBox(height: kSpacing),
                    _buildTeamMember(data: controller.getMember()),
                    const SizedBox(height: kSpacing),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                      child: GetPremiumCard(onPressed: () {}),
                    ),
                    const SizedBox(height: kSpacing),
                    const Divider(thickness: 1),
                    const SizedBox(height: kSpacing),
                    _buildRecentMessages(data: controller.getChatting()),
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
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(kBorderRadius),
                      bottomRight: Radius.circular(kBorderRadius),
                    ),
                    child: Sidebar(data: controller.getSelectedProject())),
              ),
              StreamBuilder<String>(
                  stream: controller.streamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.data == "welcome") {
                      return Flexible(
                        flex: 9,
                        child: Column(
                          children: [
                            const SizedBox(height: kSpacing),
                            _buildHeader(),
                            const SizedBox(height: kSpacing * 2),
                            // _buildProgress(),
                            // const SizedBox(height: kSpacing * 2),
                            buildAvaiTrsSection(
                              crossAxisCount: 6,
                              crossAxisCellCount:
                                  (constraints.maxWidth < 1360) ? 3 : 2,
                            ),
                            const SizedBox(height: kSpacing * 2),
                            // _buildActiveProject(
                            //   data: controller.getActiveProject(),
                            //   crossAxisCount: 6,
                            //   crossAxisCellCount: (constraints.maxWidth < 1360) ? 3 : 2,
                            // ),
                            // const SizedBox(height: kSpacing),
                          ],
                        ),
                      );
                    } else if (snapshot.data == "cart") {
                      return Flexible(
                        flex: 9,
                        child: Column(
                          children: [
                            const SizedBox(height: kSpacing),
                            _buildHeader(),
                            const SizedBox(height: kSpacing * 2),
                            _buildInBasketTrainings(),
                            const SizedBox(height: kSpacing * 2),
                          ],
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    const SizedBox(height: kSpacing / 2),
                    _buildProfile(),
                    const Divider(thickness: 1),
                    // const SizedBox(height: kSpacing),
                    // _buildTeamMember(data: controller.getMember()),
                    // const SizedBox(height: kSpacing),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                    //   child: GetPremiumCard(onPressed: () {}),
                    // ),
                    // const SizedBox(height: kSpacing),
                    // const Divider(thickness: 1),
                    // const SizedBox(height: kSpacing),
                    // _buildRecentMessages(data: controller.getChatting()),
                  ],
                ),
              )
            ],
          );
        },
      )),
    );
  }

  Widget _buildInBasketTrainings({
    int crossAxisCount = 6,
    int crossAxisCellCount = 2,
    Axis headerAxis = Axis.horizontal,
  }) {
    return FutureBuilder<List<TrainingModel>>(
      future: controller.getTraineesBasket(controller.uid),
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

  Widget _buildProgress({Axis axis = Axis.horizontal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: (axis == Axis.horizontal)
          ? Row(
              children: [
                Flexible(
                  flex: 9,
                  child: ProgressCard(
                    data: const ProgressCardData(
                      totalUndone: 10,
                      totalTaskInProress: 2,
                    ),
                    onPressedCheck: () {},
                  ),
                )
              ],
            )
          : Column(
              children: [
                ProgressCard(
                  data: const ProgressCardData(
                    totalUndone: 100,
                    totalTaskInProress: 2,
                  ),
                  onPressedCheck: () {},
                )
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

  Widget _buildActiveProject({
    required List<ProjectCardData> data,
    int crossAxisCount = 6,
    int crossAxisCellCount = 2,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: ActiveProjectCard(
        onPressedSeeAll: () {},
        child: StaggeredGridView.countBuilder(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          itemCount: data.length,
          addAutomaticKeepAlives: false,
          mainAxisSpacing: kSpacing,
          crossAxisSpacing: kSpacing,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ProjectCard(data: data[index]);
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.fit(crossAxisCellCount),
        ),
      ),
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => CartScreen(
                          //       isLogged: logSnapshot.data!,
                          //       trainingsIDs: profiles[0].trainings!,
                          //       totalPrice: profiles[0].totalPrice,
                          //     ),
                          //   ),
                          // );
                          controller.streamController.add("cart");
                          controller.streamController.close();
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

  Widget _buildTeamMember({required List<ImageProvider> data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TeamMember(
            totalMember: data.length,
            onPressedAdd: () {},
          ),
          const SizedBox(height: kSpacing / 2),
          ListProfilImage(maxImages: 6, images: data),
        ],
      ),
    );
  }

  Widget _buildRecentMessages({required List<ChattingCardData> data}) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacing),
        child: RecentMessages(onPressedMore: () {}),
      ),
      const SizedBox(height: kSpacing / 2),
      ...data
          .map(
            (e) => ChattingCard(data: e, onPressed: () {}),
          )
          .toList(),
    ]);
  }
}
