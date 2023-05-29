import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:octo_image/octo_image.dart';
import 'package:theteam_gyp/admin-interface/login_or_register_page.dart';
import 'package:theteam_gyp/admin-interface/models/UserModel.dart';
import 'package:theteam_gyp/admin-interface/trainings/screens/admin_list_trainings.dart';
import 'package:theteam_gyp/user-interface/constans/mycolors.dart';
import 'package:theteam_gyp/user-interface/screens/settings_screen.dart';

class AdminSettingsPageWidget extends StatefulWidget {
  const AdminSettingsPageWidget({Key? key}) : super(key: key);

  @override
  _AdminSettingsPageWidgetState createState() =>
      _AdminSettingsPageWidgetState();
}

class _AdminSettingsPageWidgetState extends State<AdminSettingsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final myfullName = '${userModel.firstname}  ${userModel.lastname}';
  final myEmail = userModel.email;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //_model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: MyColors.primaryBackground,
        appBar: AppBar(
          backgroundColor: MyColors.bluegreenish,
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.home_rounded,
                color: MyColors.primaryText,
                size: 30,
              ),
              onPressed: () {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => SettingsPage()));
                // print('HomeButton pressed ...');
              },
            ),
          ],
          centerTitle: true,
          elevation: 4,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 191.0,
                child: Stack(
                  children: [
                    // Container(
                    //   width: double.infinity,
                    //   height: 140.0,
                    //   decoration: const BoxDecoration(
                    //     color: MyColors.secondaryBackground,
                    //     image: DecorationImage(
                    //       fit: BoxFit.cover,

                    //       // BACKGROUND IMAGE !
                    //       image: CachedNetworkImageProvider(
                    //         'https://images.unsplash.com/photo-1434394354979-a235cd36269d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fG1vdW50YWluc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 1.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 0.0, 16.0),
                        child: Container(
                          width: 90.0,
                          height: 90.0,
                          decoration: BoxDecoration(
                            color: MyColors.accent2,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: MyColors.secondary,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                4.0, 4.0, 4.0, 4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: OctoImage(
                                placeholderBuilder: OctoPlaceholder.blurHash(
                                    'BwH2.zxupJyGawt8'),
                                image: CachedNetworkImageProvider(
                                  userModel.profilePicture,
                                ),
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                child: Text(
                  myfullName,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(24.0, 4.0, 0.0, 16.0),
                child: Text(
                  myEmail,
                  /*'andrew@domainname.com',*/
                  // style: FFTheme.of(context).labelMedium,
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 4.0, 0.0, 0.0),
                child: Text(
                  'Account',
                  // style: FFTheme.of(context).labelMedium,
                ),
              ),

              // Generated code for this Column Widget...
              /*Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 1, 1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: OctoImage(
                              placeholderBuilder: OctoPlaceholder.blurHash(
                                'LKN^h]x^^lxHxGWVX5Rj~qMx9Fba',
                              ),
                              image: const NetworkImage(
                                'https://theteam.com.tn/wp-content/uploads/2023/04/ichrak-safe-.jpg',
                              ),
                              width: 339,
                              height: 378,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 4, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Training Title',
                                  style: TextStyle(fontSize: 18,),
                                  //style: FFTheme.of(context).headlineSmall,
                                ),
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 8, 0),
                                  child: AutoSizeText(
                                    '#LessonReference',
                                    textAlign: TextAlign.start,
                                     */ /* style:
                                    FFTheme.of(context).labelMedium.override(
                                      fontFamily: 'Poppins',*/ /*
                                 */ /*   color: MyColors.accent3,
                                    ),*/ /*
                                  ),
                               ),
                               const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 8, 0),
                                  child: AutoSizeText(
                                    'Lesson Creation Date jj/mm/yyyy',
                                    textAlign: TextAlign.start,
                                    //style: FFTheme.of(context).labelMedium,
                                  ),
                                ),

                                Wrap(
                                  spacing: 20.0,
                                  alignment: WrapAlignment.start,
                                  children: const [
                                    ChoiceChip(
                                      label: Text('Option 1' , style: TextStyle(color: Colors.black)),
                                      avatar: Icon(Icons.school_outlined),
                                      selectedColor: MyColors.secondary,
                                      labelStyle: TextStyle(
                                        color: MyColors.primaryText,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      backgroundColor: MyColors.accent4,
                                      selected: true,
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                              child: Text(
                                'Click To view Details :',
                               // style: FFTheme.of(context).bodyMedium,
                              ),
                            ),
                            IconButton(
                             */ /* borderColor: Colors.transparent,
                              borderRadius: 30,
                              borderWidth: 1,
                              buttonSize: 60,*/ /*
                              icon: const FaIcon(
                                FontAwesomeIcons.chevronRight,
                                color: MyColors.primaryText,
                                size: 30,
                              ),
                              onPressed: () {
                                print('redirect to view training Details ...');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                         */ /* borderColor: Colors.transparent,
                          borderRadius: 20,
                          borderWidth: 1,
                          buttonSize: 40,*/ /*
                          icon: const FaIcon(
                            FontAwesomeIcons.trash,
                             color: MyColors.error,
                            size: 20,
                          ),
                          onPressed: () {
                            print('Pressed to delete Training ...');
                          },
                        ),
                        IconButton(

                        */ /*  borderColor: Colors.transparent,
                          borderRadius: 20,
                          borderWidth: 1,
                          buttonSize: 40,*/ /*
                          icon: const FaIcon(
                            FontAwesomeIcons.pen,
                            color: MyColors.success,
                            size: 20,
                          ),
                          onPressed: () {
                            print('Pressed to Edit Training ...');
                          },
                        ),
                        IconButton(
                        */ /*  borderColor: Colors.transparent,
                          borderRadius: 20,
                          borderWidth: 1,
                          buttonSize: 40,*/ /*
                          icon: const FaIcon(
                            FontAwesomeIcons.solidEye,
                            color: MyColors.primary,
                            size: 20,
                          ),
                          onPressed: () {
                            print('Pressed to View Training Details ...');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
*/

              /////////////////

              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const ProfilePageWidget(),
                    //   ),
                    // );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: MyColors.secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 1.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Icon(
                            Icons.account_circle_outlined,
                            color: Color(0xFF57636C),
                            size: 24.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'View & Edit Profile',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF101213),
                                /*fontSize: 18.0,*/
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: MyColors.secondaryText,
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {},
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: MyColors.secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 1.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Icon(
                            Icons.notifications_none,
                            color: MyColors.secondaryText,
                            size: 24.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Notification Center',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF101213),
                                /*fontSize: 18.0,*/
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF57636C),
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const ChangePasswordPage()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: MyColors.secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 1.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Icon(
                            Icons.lock_outlined,
                            color: MyColors.secondaryText,
                            size: 24.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Security & Password',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF101213),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: MyColors.secondaryText,
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 0.0, 0.0),
                child: Text(
                  'Administration',
                  // style: FFTheme.of(context).labelMedium,
                ),
              ),

              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {},
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: MyColors.secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 1.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.usersCog,
                            color: MyColors.secondaryText,
                            size: 24.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Manage Users',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF101213),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: MyColors.secondaryText,
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AdminListTrainings()));
                    /* context.pushNamed('HomePage');*/
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: MyColors.secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 1.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Icon(
                            Icons.school_outlined,
                            color: MyColors.secondaryText,
                            size: 30.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Manage Trainings',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF101213),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: MyColors.secondaryText,
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {},
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: MyColors.secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 1.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Icon(
                            Icons.history_edu,
                            color: MyColors.secondaryText,
                            size: 30.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Manage Lessons',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF101213),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: MyColors.secondaryText,
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {},
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: MyColors.secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 1.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.tasks,
                            color: MyColors.secondaryText,
                            size: 30.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Manage Categories',
                              // style: FFTheme.of(context).labelLarge,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: MyColors.secondaryText,
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {},
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: MyColors.secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 1.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.tags,
                            color: MyColors.secondaryText,
                            size: 30.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Manage Tags',
                              // style: FFTheme.of(context).labelLarge,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: MyColors.secondaryText,
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 0.0, 0.0),
                child: Text(
                  'Assign management',
                  // style: FFTheme.of(context).labelMedium,
                ),
              ),

              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: MyColors.secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3.0,
                        color: Color(0x33000000),
                        offset: Offset(0.0, 1.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        12.0, 12.0, 12.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.hive,
                          color: MyColors.secondaryText,
                          size: 30.0,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Assign Lessons to Trainings',
                            // style: FFTheme.of(context).labelLarge,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0.9, 0.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: MyColors.secondaryText,
                              size: 18.0,
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
                    const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: MyColors.secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3.0,
                        color: Color(0x33000000),
                        offset: Offset(0.0, 1.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        12.0, 12.0, 12.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Icon(
                          Icons.person_add_alt_1,
                          color: MyColors.secondaryText,
                          size: 30.0,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Assign Lessons to Trainings',
                            // style: FFTheme.of(context).labelLarge,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0.9, 0.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: MyColors.secondaryText,
                              size: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 0.0, 0.0),
                child: Text(
                  'App Settings',
                  // style: FFTheme.of(context).labelMedium,
                ),
              ),

              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: MyColors.secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3.0,
                        color: Color(0x33000000),
                        offset: Offset(0.0, 1.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        12.0, 12.0, 12.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Icon(
                          Icons.help_outline_rounded,
                          color: MyColors.secondaryText,
                          size: 24.0,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Support & Reclamation',
                            // style: FFTheme.of(context).labelLarge,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0.9, 0.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: MyColors.secondaryText,
                              size: 18.0,
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
                    const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: MyColors.secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3.0,
                        color: Color(0x33000000),
                        offset: Offset(0.0, 1.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        12.0, 12.0, 12.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Icon(
                          Icons.privacy_tip_rounded,
                          color: MyColors.secondaryText,
                          size: 24.0,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Terms of Service',
                            // style: FFTheme.of(context).labelLarge,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0.9, 0.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: MyColors.secondaryText,
                              size: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Logout Button !
              Align(
                alignment: AlignmentDirectional.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginOrRegisterPage()));

                      print('LogoutButton pressed ...');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFF1F4F8),
                      elevation: 0,
                      minimumSize: const Size(150.0, 44.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(38.0),
                        side: const BorderSide(
                          color: Color(0xFFE0E3E7),
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Text(
                      'Log Out',
                      style: MyColors()
                          .labelMedium
                          .copyWith(color: MyColors.secondaryText),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
