import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:theteam_gyp/admin-interface/EditProfilePage/EditProfilePageWidget.dart';
import 'package:theteam_gyp/admin-interface/Settings.dart';
import 'package:theteam_gyp/admin-interface/categories/list_categories.dart';
import 'package:theteam_gyp/admin-interface/home_page.dart';
import 'package:theteam_gyp/admin-interface/lessons/all_lessons_admin_side.dart';
import 'package:theteam_gyp/admin-interface/lessons/user_side_of_all_lessons.dart';
import 'package:theteam_gyp/admin-interface/login_or_register_page.dart';
import 'package:theteam_gyp/admin-interface/tags/list_tags.dart';
import 'package:theteam_gyp/admin-interface/trainings/admin_list_trainings.dart';
import 'package:theteam_gyp/admin-interface/trainings/list_trainings.dart';
import 'package:theteam_gyp/admin-interface/users_list_page.dart';
import 'package:theteam_gyp/admin-interface/welcome_screen.dart';
import 'package:theteam_gyp/user-interface/constans/mycolors.dart';

class DashboardAdminSummaryWidget extends StatefulWidget {
  final String? userId;
  DashboardAdminSummaryWidget({Key? key, String? this.userId})
      : super(key: key);

  @override
  _DashboardAdminSummaryWidgetState createState() =>
      _DashboardAdminSummaryWidgetState();
}

class _DashboardAdminSummaryWidgetState
    extends State<DashboardAdminSummaryWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  Stream<int> getUserCount() {
    return FirebaseFirestore.instance
        .collection('Users')
        .snapshots()
        .map((querySnapshot) => querySnapshot.size);
  }

  Stream<int> getTrainingCount() {
    return FirebaseFirestore.instance
        .collection('trainings')
        .snapshots()
        .map((querySnapshot) => querySnapshot.size);
  }

  final Stream<List<DocumentSnapshot>> htmleditorStream = FirebaseFirestore
      .instance
      .collection('htmleditor')
      .snapshots()
      .map((QuerySnapshot querySnapshot) {
    return querySnapshot.docs;
  });

/*
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }
*/

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: MyColors.secondaryBackground,
        appBar: AppBar(
          backgroundColor: MyColors.secondaryBackground,
          automaticallyImplyLeading: true,
          title: Text(
            'Admin Dashboard / Nav',
            style: MyColors().labelXLarge,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.settings_rounded,
              color: MyColors.secondary,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminSettingsPageWidget(),
                ),
              );
            },
          ),
          actions: [
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ProfilePageWidget(),
                //   ),
                // );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.accent2,
                    border: Border.all(
                      color: MyColors.secondary, // use the given color code
                      width: 2, // set the border width
                    ),
                  ),
                  // child: ClipOval(
                  //   child: OctoImage(
                  //       placeholderBuilder:
                  //           OctoPlaceholder.blurHash('BwH2.zxupJyGawt8'),
                  //       image: CachedNetworkImageProvider(
                  //         userModel.profilePicture ??
                  //             'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                  //       ),
                  //       width: 50,
                  //       height: 50,
                  //       fit: BoxFit.cover,
                  //       errorBuilder: OctoError.circleAvatar(
                  //         backgroundColor: MyColors.secondaryText,
                  //         text: Text(
                  //           "Profile",
                  //           style: MyColors().labelSmall,
                  //         ),
                  //       )
                  //       //progressIndicatorBuilder: OctoProgressIndicator.circularProgressIndicator(),
                  //       ),
                  // ),
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Log out'),
                              content: const Text(
                                  'Are you sure you want to log out?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginOrRegisterPage(),
                                      ),
                                    );
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFF1F4F8),
                        elevation: 0,
                        minimumSize: const Size(50.0, 34.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(38.0),
                          side: const BorderSide(
                            color: Color(0xFFE0E3E7),
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: const Text(
                        'LogOut',
                        style: TextStyle(
                          color: MyColors.secondaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                /*       Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 10.0, 0.0, 10.0),
                  child: Text(
                    'Admin Dashboard / Nav',
                    style: MyColors().labelXLarge,
                  ),
                ),*/

                const SizedBox(
                  width: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    height: 140.0,
                    constraints: const BoxConstraints(
                      maxHeight: 140.0,
                    ),
                    decoration: const BoxDecoration(
                      color: MyColors.secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 1.0),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 4.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        /*  crossAxisAlignment: CrossAxisAlignment.start,*/
                        children: [
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Below is the admin navigation buttons',
                              style: MyColors().labelSmall,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 0.0),
                              child: ListView(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const AdminListTrainings()));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 8.0, 8.0),
                                      child: Container(
                                        width: 130.0,
                                        decoration: BoxDecoration(
                                          color: MyColors.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: MyColors.lineColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Material(
                                          color: MyColors.Grid8,
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                12.0, 12.0, 12.0, 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.fitness_center,
                                                  color: MyColors.info,
                                                  size: 20.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Manage Trainings',
                                                    style:
                                                        MyColors().labelMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         UsersList() /* LoginPageWidget()*/));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 8.0, 8.0),
                                      child: Container(
                                        width: 130.0,
                                        decoration: BoxDecoration(
                                          color: MyColors.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: MyColors.lineColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Material(
                                          color: MyColors.Grid8,
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                12.0, 12.0, 12.0, 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.door_back_door_outlined,
                                                  color: MyColors.info,
                                                  size: 20.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Login Page (NEW UI)',
                                                    style:
                                                        MyColors().labelMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const UsersList()));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 8.0, 8.0),
                                      child: Container(
                                        width: 130.0,
                                        decoration: BoxDecoration(
                                          color: MyColors.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: MyColors.lineColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Material(
                                          color: MyColors.Grid0,
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                12.0, 12.0, 12.0, 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.person,
                                                  color: MyColors.info,
                                                  size: 20.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Manage users',
                                                    style:
                                                        MyColors().labelMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             AllLessons()));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 8.0, 8.0),
                                      child: Container(
                                        width: 130.0,
                                        decoration: BoxDecoration(
                                          color: MyColors.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: MyColors.lineColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Material(
                                          color: MyColors.Grid0,
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                12.0, 12.0, 12.0, 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.library_books_rounded,
                                                  color: MyColors.info,
                                                  size: 20.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'View Lessons - Admin',
                                                    style:
                                                        MyColors().labelMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const MyLessonsPage()));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 8.0, 8.0),
                                      child: Container(
                                        width: 130.0,
                                        decoration: BoxDecoration(
                                          color: MyColors.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: MyColors.lineColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Material(
                                          color: MyColors.Grid0,
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                12.0, 12.0, 12.0, 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons
                                                      .my_library_books_outlined,
                                                  color: MyColors.info,
                                                  size: 20.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'View Lessons - Users',
                                                    style:
                                                        MyColors().labelMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const ListTags()));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 8.0, 8.0),
                                      child: Container(
                                        width: 130.0,
                                        decoration: BoxDecoration(
                                          color: MyColors.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: MyColors.lineColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Material(
                                          color: MyColors.Grid0,
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                12.0, 12.0, 12.0, 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.tag_rounded,
                                                  color: MyColors.info,
                                                  size: 20.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Tags Management',
                                                    style:
                                                        MyColors().labelMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const ListCategories()));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 8.0, 8.0),
                                      child: Container(
                                        width: 130.0,
                                        decoration: BoxDecoration(
                                          color: MyColors.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: MyColors.lineColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Material(
                                          color: MyColors.Grid0,
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                12.0, 12.0, 12.0, 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.format_list_bulleted,
                                                  color: MyColors.info,
                                                  size: 20.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Categories Management',
                                                    style:
                                                        MyColors().labelMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const ListTags()));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 8.0, 8.0),
                                      child: Container(
                                        width: 130.0,
                                        decoration: BoxDecoration(
                                          color: MyColors.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: MyColors.lineColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Material(
                                          color: MyColors.Grid0,
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                12.0, 12.0, 12.0, 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.tag_rounded,
                                                  color: MyColors.info,
                                                  size: 20.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Tags Management',
                                                    style:
                                                        MyColors().labelMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             HomePage()));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 8.0, 8.0),
                                      child: Container(
                                        width: 130.0,
                                        decoration: BoxDecoration(
                                          color: MyColors.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: MyColors.lineColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Material(
                                          color: MyColors.Grid5,
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                12.0, 12.0, 12.0, 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.home_rounded,
                                                  color: MyColors.info,
                                                  size: 20.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'HomePage (old)',
                                                    style:
                                                        MyColors().labelMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             SettingsPage()));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 8.0, 8.0),
                                      child: Container(
                                        width: 130.0,
                                        decoration: BoxDecoration(
                                          color: MyColors.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: MyColors.lineColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Material(
                                          color: MyColors.Grid5,
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                12.0, 12.0, 12.0, 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons
                                                      .settings_applications_sharp,
                                                  color: MyColors.info,
                                                  size: 20.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'SettingsPage (old)',
                                                    style:
                                                        MyColors().labelMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const ListTrainings()));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 8.0, 8.0),
                                      child: Container(
                                        width: 130.0,
                                        decoration: BoxDecoration(
                                          color: MyColors.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: MyColors.lineColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Material(
                                          color: MyColors.Grid5,
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                12.0, 12.0, 12.0, 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.line_weight_rounded,
                                                  color: MyColors.info,
                                                  size: 20.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Trainings (old)',
                                                    style:
                                                        MyColors().labelMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(24.0, 4.0, 0.0, 0.0),
                  child: Text(
                    'App Stats & infos',
                    textAlign: TextAlign.start,
                    style: MyColors().labelSmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 12.0, 16.0, 12.0),
                  child: GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.0,
                    ),
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 0.0,
                        decoration: BoxDecoration(
                          color: MyColors.primaryBackground,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              12.0, 12.0, 12.0, 12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.supervisor_account_rounded,
                                color: MyColors.primaryText,
                                size:
                                    MediaQuery.of(context).size.shortestSide <=
                                            600
                                        ? 15.0
                                        : 20.0,
                              ),
                              SizedBox(height: 3.0),
                              StreamBuilder<int>(
                                stream: getUserCount(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      '${snapshot.data}',
                                      style: MyColors().labelSmall,
                                      textAlign: TextAlign.center,
                                      /* style: FFTheme.of(context).displaySmall, */
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                              if (MediaQuery.of(context).size.shortestSide >
                                  600)
                                Text(
                                  'Users',
                                  textAlign: TextAlign.center,
                                  style: MyColors().labelSmall,
                                  // style: FFTheme.of(context).labelMedium,
                                ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: MyColors.secondary,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fitness_center_rounded,
                                color: MyColors.primaryText,
                                size:
                                    MediaQuery.of(context).size.shortestSide <=
                                            600
                                        ? 15.0
                                        : 20.0,
                              ),
                              const SizedBox(height: 3.0),
                              StreamBuilder<int>(
                                stream: getTrainingCount(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      '${snapshot.data}',
                                      style: MyColors().labelSmall,
                                      textAlign: TextAlign.center,
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                      'Error: ${snapshot.error}',
                                      style: MyColors()
                                          .labelSmall
                                          .copyWith(color: MyColors.error),
                                      textAlign: TextAlign.center,
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                              if (MediaQuery.of(context).size.shortestSide >
                                  600)
                                Text(
                                  'Trainings',
                                  style: MyColors().labelSmall,
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: MyColors.Grid9,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.pie_chart_rounded,
                                color: MyColors.primaryText,
                                size:
                                    MediaQuery.of(context).size.shortestSide <=
                                            600
                                        ? 15.0
                                        : 20.0,
                              ),
                              SizedBox(height: 3.0),
                              Text(
                                '45.6',
                                style: MyColors().labelSmall,
                                textAlign: TextAlign.center,
                              ),
                              if (MediaQuery.of(context).size.shortestSide >
                                  600)
                                Text(
                                  'Stats',
                                  style: MyColors().labelSmall,
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 0.0, 12.0),
                  child: Text(
                    'Your transactions',
                    textAlign: TextAlign.start,
/*
style: FFTheme.of(context).labelLarge,
*/
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 12.0),
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(
                            maxWidth: 570.0,
                          ),
                          decoration: BoxDecoration(
                            color: MyColors.secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: MyColors.primaryBackground,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 12.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'List Item Title',
                                        style: MyColors().labelMedium,
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsetsDirectional.fromSTEB(
                                      //       0.0, 4.0, 0.0, 0.0),
                                      //   child: AutoSizeText(
                                      //     'The LogOut button is under the Profile Circular Image \n untill we make a Stack for DropDown Menu.',
                                      //     style: MyColors().labelSmall,
                                      //     maxLines: 2,
                                      //     overflow: TextOverflow.ellipsis,
                                      //     minFontSize: 12,
                                      //     textAlign: TextAlign.left,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                Text('\$0.00',
                                    textAlign: TextAlign.end,
                                    style: MyColors().labelNormal),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
