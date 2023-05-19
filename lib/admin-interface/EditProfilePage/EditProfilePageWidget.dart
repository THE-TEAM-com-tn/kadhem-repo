// import 'package:elearning_provider/utils/mycolors.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:elearning_provider/models/UserModel.dart';
// import 'package:elearning_provider/providers/EditProfileProvider.dart';
// import 'EditProfilePageModel.dart';
// // Mine : old : https://pastebin.com/Y8S6R28g
// import 'package:intl/intl.dart';
// import 'package:elearning_provider/UI/Pages/EditProfilePage/InputWidget_EditProfile.dart';
// import 'package:image_picker/image_picker.dart';
// import 'EditProfilePageModel.dart';

// class ProfilePageWidget extends StatefulWidget {
//   const ProfilePageWidget({Key? key}) : super(key: key);

//   @override
//   _ProfilePageWidgetState createState() => _ProfilePageWidgetState();
// }

// class _ProfilePageWidgetState extends State<ProfilePageWidget> {
//   late EditProfilePageModel _model;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     _model = EditProfilePageModel();
//     _model.yourNameController ??= TextEditingController();
//     _model.emailAddressController ??= TextEditingController();
//     _model.myBioController ??= TextEditingController();
//     _model.phoneNumberController ??= TextEditingController();
//     _model.addressController ??= TextEditingController();
//     _model.companyController ??= TextEditingController();
//     _model.lastNameController ??= TextEditingController();
//     _model.birthDateController ??= TextEditingController();

//     super.initState();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       backgroundColor: const Color(0xFFFFFFFF),

//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70.0),


//               child: AppBar(
//                 backgroundColor: const Color(0xFFFFFFFF),
//                automaticallyImplyLeading: false,
//                titleSpacing: 0,
//                title: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                 IconButton(
//                   icon: const Icon(
//                     Icons.arrow_back_rounded,
//                     color: Colors.black,
//                     size: 30.0,
//                   ),
//                   onPressed: () async {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 Expanded(
//                   child: Center(
//                     child: Text(
//                       'PROFILE',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontFamily: 'Lexend Deca',
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(
//                     Icons.notifications,
//                     color: Colors.black,
//                     size: 30.0,
//                   ),
//                   onPressed: () {
//                     // Handle button press
//                   },
//                 ),
//                ],
//               ),
//             centerTitle: true,
//             elevation: 1.0,
//           ),
//     ),




//       body: SingleChildScrollView(

//         child: SafeArea(


//         child: Consumer<EditProfileProvider>(
//         builder: (context, value, child) {

//       if (value.loading == true) {
//         print(userModel.userId);
//         value.fetchData(userModel.userId);
//       }
//       if (value.documentSnapshot == null) {
//         return const CircularProgressIndicator();
//       } else {
//         _model.birthDateController!.text = userModel.birthDate;
//         final Map<String, dynamic> doc =
//         value.documentSnapshot!.data() as Map<String, dynamic>;

//         return Form(
//           key: _formKey,

//           child: Column(
//             mainAxisSize: MainAxisSize.max,

//             children: [
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [

//                   Padding(
//                     padding: const EdgeInsetsDirectional.only(top: 20.0),
//                     child: Container(
//                       width: 100.0,
//                       height: 100.0,

//                       decoration: const BoxDecoration(
//                         color: Color(0xFFDBE2E7),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsetsDirectional.fromSTEB(
//                             2.0, 2.0, 2.0, 2.0),

//                         child: Container(
//                           width: 90.0,
//                           height: 90.0,
//                           clipBehavior: Clip.antiAlias,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                           ),

//                           child: !value.imageUpdating
//                               ? Image.network(
//                             userModel.profilePicture,
//                             fit: BoxFit.fitWidth,
//                           )
//                               : const CircularProgressIndicator(),

//                         ),
//                       ),
//                     ),
//                   ),


//                 ],
//               ),


//               Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(
//                     0.0, 12.0, 0.0, 16.0),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,

//                   children: [


//                    // PENCIL ICON - I DELETE IT !

//                    InkWell(
//                      onTap:() async {
//                        final ImagePicker picker = ImagePicker();
//                        XFile? image = await picker.pickImage(
//                            source: ImageSource.camera);
//                        if (image != null) {
//                          final bytes = await image.readAsBytes();
//                          final name = image.path.split('/').last;
//                          value.updateImage(name, bytes);
//                        }
//                      },

//                      child: const Padding(
//                         padding:
//                         EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
//                         child: FaIcon(

//                           FontAwesomeIcons.pen,
//                           color: Colors.green,
//                           // color: FFTheme.of(context).secondary,
//                           size: 24.0,
//                         ),


//                       ),
//                    ),

//                     InkWell(
//                       onTap: () {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text("Delete Profile Picture"),
//                               content: const Text("Are you sure you want to delete your profile picture?"),
//                               actions: <Widget>[
//                                 TextButton(
//                                   child: const Text("CANCEL", style: TextStyle(color: MyColors.success),),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                                 TextButton(
//                                   child: const Text("DELETE" , style: TextStyle(color: MyColors.error),),
//                                   onPressed: () {
//                                     value.defaultImage(userModel.userId);
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                       child: const Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
//                         child: FaIcon(
//                           FontAwesomeIcons.trash,
//                           color: Colors.red,
//                           size: 24.0,
//                         ),
//                       ),
//                     ),



//                   ],
//                 ),
//               ),

//       // Email Address
//               Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
//                 child: InputWidgetEditProfile(
//                   validator: (value) {
//                     if (_model.emailAddressControllerValidator(value) != null) {
//                       return _model.emailAddressControllerValidator(value);
//                     }
//                     return null;
//                   },
//                   controller: _model.emailAddressController,
//                   text: 'Your Email Address',
//                   initialValue: doc['email'] ?? '',
//                   enabled: false, // Set enabled to false to make the field not changeable
//                   maxLines: 1,
//                   obscure: false,
//                   labelText: 'Email Address',
//                 ),
//               ),

//               Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [

//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(
//                               20.0, 0.0, 20.0, 16.0),

//                           child:

//                           InputWidgetEditProfile(
//                           obscure: false,

//                             validator: (value) {
//                               if (_model.yourNameControllerValidator(value) !=
//                                   null) {
//                                 return _model.yourNameControllerValidator(value);
//                               }
//                               return null;
//                             },
//                             controller: _model.yourNameController,

//                             text: 'Your First Name',
//                             initialValue: doc['firstName'] ?? '',
//                             enabled: true,
//                             maxLines: 1,
//                             onChanged: (value) {
//                               userModel.firstname = value;

//                             },
//                             labelText: 'First Name',

//                           ),
//                         ),
//                       ),

//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(
//                               20.0, 0.0, 20.0, 16.0),
//                           child:

//                           InputWidgetEditProfile(
//                             obscure: false,
//                             validator: (value) {
//                               if (_model.lastNameControllerValidator(value) !=
//                                   null) {
//                                 return _model.lastNameControllerValidator(value);
//                               }
//                               return null;
//                             },
//                             controller: _model.lastNameController,
//                             text: 'Your Last Name',
//                             initialValue: doc['lastName'] ?? '',
//                             enabled: true,
//                             maxLines: 1,
//                             onChanged: (value) {
//                               userModel.lastname = value;
//                             },

//                             labelText: 'Last Name',
//                           ),


//                         ),
//                       ),
//                     ],
//                   ),
//                 /*],*/
//              // ), // wrap ends here



//                  // PHONE NUMBER
//               Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(
//                     20.0, 0.0, 20.0, 12.0),
//                 child:

//                 InputWidgetEditProfile(
//                     obscure: false,
//                     validator: (value) {
//                       if (_model.phoneNumberControllerValidator(value) !=
//                           null) {
//                         return _model
//                             .phoneNumberControllerValidator(value);
//                       }
//                       return null;
//                     },
//                     controller: _model.phoneNumberController,
//                     text: 'Your Phone Number',
//                     initialValue: doc['phone_number'] ?? '',
//                     enabled: true,
//                     maxLines: 1,
//                     onChanged: (value) {
//                       userModel.phoneNumber = value;
//                     },
//                   labelText: 'Phone Number',

//                 ),
//               ),


//               Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(
//                     20.0, 0.0, 20.0, 12.0),
//                 child:

//                 InputWidgetEditProfile(
//                   obscure: false,
//                   validator: (value) {
//                     if (_model.companyControllerValidator(value) !=
//                         null) {
//                       return _model.companyControllerValidator(value);
//                     }
//                     return null;
//                   },
//                   controller: _model.companyController,
//                   text: 'Your Company',
//                   initialValue: doc['company'] ?? '',
//                   enabled: true,
//                   maxLines: 1,
//                   onChanged: (value) {
//                     userModel.company = value;
//                   },
//                 labelText: 'Company',
//                 ),

//               ),



//               Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(
//                     20.0, 0.0, 20.0, 12.0),
//                 child:

//                 InputWidgetEditProfile(
//                   obscure: false,
//                   validator: (value) {
//                     if (_model.addressControllerValidator(value) !=
//                         null) {
//                       return _model.addressControllerValidator(value);
//                     }
//                     return null;
//                   },
//                   controller: _model.addressController,
//                   text: 'Your Address: Street Address / City / State/Province/ Zip ~ PostalCode / Country',

//                 initialValue: doc['address'] ?? '',
//                   enabled: true,
//                   maxLines: 1,
//                   onChanged: (value) {
//                     userModel.address = value;
//                   },

//                   labelText: 'Address, City, Country   (Optional)',

//                 ),


//               ),

//               Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(
//                     20.0, 0.0, 20.0, 12.0),
//                 child:

//                 TextFormField(
//                   onTap: () async {
//                     //  DateTime now = new DateTime.now();
//                     DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(1950),
//                         lastDate: DateTime.now());
//                     if (pickedDate != null) {
//                       String formattedDate =
//                       DateFormat('yyyy-MM-dd').format(pickedDate);
//                       userModel.birthDate = formattedDate;
//                       _model.birthDateController!.text = formattedDate;
//                     }
//                   },
//                 enabled: true,
//                 readOnly: true,
//                 controller: _model.birthDateController,
//                 validator: _model.birthDateControllerValidator,

//                   obscureText: false,
//                   decoration: InputDecoration(
//                     labelText: 'Your Birth Date ',

//                     enabledBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         color: Color(0xFFF1F4F8),
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         color: Color(0x00000000),
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         color: Color(0x00000000),
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         color: Color(0x00000000),
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     filled: true,
//                     fillColor: const Color(0xFFFFFFFF),

//                     contentPadding:
//                     const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
//                   ),
//                   maxLines: null,
//                   keyboardType: TextInputType.datetime,

//                 ),

//               ),

//                       Padding(
//                         padding: const EdgeInsetsDirectional.fromSTEB(
//                             20.0, 0.0, 20.0, 12.0),
//                         child: InputWidgetEditProfile(
//                           obscure: false,
//                           validator: (value) {
//                             if (_model.birthDateControllerValidator(value) !=
//                                 null) {
//                               return _model.birthDateControllerValidator(value);
//                             }
//                             return null;
//                           },
//                           controller: _model.myBioController,
//                           text: 'bio',
//                           initialValue: doc['bio'] ?? '',
//                           enabled: true,
//                           maxLines: 3,
//                           onChanged: (value) {
//                             userModel.bio = value;
//                           },
//                           textAlign: TextAlign.start,
//                           labelText: 'Your Bio',
//                         ),
//                       ),

//                       Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [


//                       ///// start new input here for test  :

//                       Expanded(
//                         child: Align(
//                           alignment: const AlignmentDirectional(0.0, 0.05),
//                           child: Padding(
//                             padding: const EdgeInsetsDirectional.fromSTEB(
//                               0.0,
//                               24.0,
//                               5.0,
//                               24.0,
//                             ),
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 final form = _formKey.currentState;
//                                 if (form!.validate()) {
//                                   if (await value.updateData(userModel)) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: const Text(
//                                           'Your data has been successfully updated!',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                         backgroundColor: Colors.green,
//                                         duration: const Duration(seconds: 3),
//                                         action: SnackBarAction(
//                                           label: 'Close',
//                                           textColor: Colors.white,
//                                           onPressed: () {
//                                             ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                                           },
//                                         ),
//                                       ),
//                                     );
//                                   } else {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: const Text(
//                                           'The email you entered already exists. Please try again with a different email.',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                         backgroundColor: Colors.red,
//                                         duration: const Duration(seconds: 3),
//                                         action: SnackBarAction(
//                                           label: 'Close',
//                                           textColor: Colors.white,
//                                           onPressed: () {
//                                             ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                                           },
//                                         ),
//                                       ),
//                                     );
//                                   }
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 minimumSize: const Size(200.0, 60.0),
//                                 primary: const Color(0xFF4B39EF),
//                                 elevation: 2.0,
//                                 side: const BorderSide(
//                                   color: Colors.transparent,
//                                   width: 1.0,
//                                 ),
//                               ),
//                               child: const Text(
//                                 'Save Changes',
//                                 style: TextStyle(
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),



//                       // BUTTON CANCEL
//                           Expanded(
//                             child: Align(
//                               alignment: const AlignmentDirectional(0.0, 0.05),


//                               child: Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(
//                                   0.0,
//                                   24.0,
//                                   5.0,
//                                   24.0,
//                                 ),


//                                 child: ElevatedButton(
//                                   onPressed: () async {
//                                     Navigator.pop(context);
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     minimumSize: const Size(200.0, 60.0),
//                                     primary: const Color(0xFF4B39EF),
//                                     elevation: 2.0,
//                                     side: const BorderSide(
//                                       color: Colors.transparent,
//                                       width: 1.0,
//                                     ),
//                                   ),


//                                   child: const Text(
//                                     'Cancel1',
//                                     style: TextStyle(
//                                       fontSize: 14.0,
//                                     ),
//                                   ),


//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(
//                         width: 50,
//                       ),
//                     ],
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
