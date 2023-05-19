// import '../../../utils/mycolors.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import '../../../models/training_model.dart';
// import '../../../providers/training_crud_model.dart';
// import '../../Widgets/G_text_form_field.dart';
// import '../../Widgets/multi_select_tags_tool.dart';
// import '../../Widgets/multi_select_tool_categroy.dart';
// import '../EditProfilePage/InputWidget_EditProfile.dart';

// class AdminEditTrainingWidget extends StatefulWidget {
//   final Training training;

//   const AdminEditTrainingWidget({Key? key, required this.training}) : super(key: key);

//   @override
//   _AdminEditTrainingWidgetState createState() =>
//       _AdminEditTrainingWidgetState();
// }

// class _AdminEditTrainingWidgetState extends State<AdminEditTrainingWidget> {
//   //late AdminEditTrainingModel _model;
//   final _formKey = GlobalKey<FormState>();

//   List<String>? _selectedCategories = [];
//   List<String>? _selectedTags= [];

//   late String imageUrl;
//   void _showMultiSelect() async {
//     final List<String>? results = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return const MultiSelect();
//       },
//     );

//     // Update UI
//     if (results != null) {
//       setState(() {
//         _selectedCategories = results;
//       });
//     }
//   }

//   void _showMultiSelect_() async {
//     final List<String>? results = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return const MultiSelectTags();
//       },
//     );

//     // Update UI
//     if (results != null) {
//       setState(() {
//         _selectedTags = results;
//       });
//     }
//     print("##### $_selectedTags");
//   }

//   void _selectImage() async {
//     ImagePicker imagePicker = ImagePicker();
//     XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
//     if (!kIsWeb) {
//       print("##### Mobile Detetcted!");
//       String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
//       print("##### Image unique name: $uniqueFileName");
//       Reference referenceRoot = FirebaseStorage.instance.ref();
//       Reference referenceDirImg = referenceRoot.child("images");
//       Reference referenceImgToUpload = referenceDirImg.child(uniqueFileName);

//       try {
//         await referenceImgToUpload.putFile(File(file!.path));
//         final image = await referenceImgToUpload.getDownloadURL();
//         setState(() {
//           imageUrl = image ;

//         });
//         print("##### Image URL: $imageUrl");
//       } catch (error) {
//         print("#####ERROR: $error");
//       }
//     } else if (kIsWeb) {
//       print("##### Web Detetcted!");

//       var imageBytes = await file?.readAsBytes();

//       String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
//       print("##### Image unique name: $uniqueFileName");

//       Reference referenceRoot = FirebaseStorage.instance.ref();
//       Reference referenceDirImg = referenceRoot.child("images");
//       Reference referenceImgToUpload = referenceDirImg.child(uniqueFileName);

//       try {
//         await referenceImgToUpload.putData(imageBytes!);
//         imageUrl = await referenceImgToUpload.getDownloadURL();
//         print("##### Image URL: $imageUrl");
//       } catch (error) {
//         print("#####ERROR: $error");
//       }
//     }
//   }

//   late String title;
//   late String description;
//   late String author;
//   late String duration;
//   late String price;
//   late String trailerVid;



//   /* final scaffoldKey = GlobalKey<ScaffoldState>();*/

//   @override
//   void initState() {
//     super.initState();
//     _selectedCategories = widget.training.category ;
//     _selectedTags = widget.training.tags ;
//     imageUrl = widget.training.image;

//   }

// /*  @override
//   void dispose() {
//    // _model.dispose();
//     super.dispose();
//   }*/

//   @override
//   Widget build(BuildContext context) {
//     final trainingProvider = Provider.of<TrainingCRUDModel>(context);

//     return Scaffold(
//       //key: scaffoldKey,
//       backgroundColor: MyColors.secondaryBackground,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70.0),

//         child: AppBar(
//           backgroundColor: const Color(0xFFFFFFFF),
//           automaticallyImplyLeading: false,
//           titleSpacing: 0,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.arrow_back_rounded,
//                   color: Colors.black,
//                   size: 30.0,
//                 ),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               const Text(
//                 'Edit Training',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontFamily: 'Lexend Deca',
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(width: 30), // Adjust this value to your preference
//             ],
//           ),
//           centerTitle: true,
//           elevation: 1.0,
//         ),


//         /*child: AppBar(
//           backgroundColor: MyColors.secondaryBackground,
//           automaticallyImplyLeading: false,
//           actions: [],
//           flexibleSpace: FlexibleSpaceBar(
//             title: Padding(
//               padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(
//                               12.0, 0.0, 0.0, 0.0),
//                           child: IconButton(
//                            *//* borderColor: Colors.transparent,
//                             borderRadius: 30.0,
//                             borderWidth: 1.0,
//                             buttonSize: 50.0,*//*
//                             icon: const Icon(
//                               Icons.arrow_back_rounded,
//                               color: MyColors.primaryText,
//                               size: 30.0,
//                             ),
//                             onPressed: () async {
//                               // context.pop();
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Padding(
//                     padding:
//                     EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 6.0),
//                     child: Text(
//                       'Edit Training',
//                       *//*style:
//                       FFTheme.of(context).headlineMedium.override(
//                         fontFamily: 'Poppins',
//                         color: MyColors.primaryText,
//                         fontSize: 20.0,
//                       ),*//*
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             centerTitle: true,
//             expandedTitleScale: 1.0,
//           ),
//           elevation: 1.0,
//         ),*/




//       ),



//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [

//                     const SizedBox(
//                       height: 10,
//                     ),

//                     Container(
//                       width: 158.0,
//                       height: 158.0,
//                       decoration: const BoxDecoration(
//                         color: MyColors.accent3,
//                         shape: BoxShape.circle,
//                       ),



//                       child: Padding(
//                         padding: const EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
//                         child: Container(
//                           width: 90.0,
//                           height: 90.0,
//                           clipBehavior: Clip.antiAlias,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                           ),
//                           child: CachedNetworkImage(
//                             imageUrl:
//                             imageUrl,
//                             fit: BoxFit.fitWidth,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),


//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 15.0),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [

//                       ElevatedButton(
//                         onPressed: _selectImage,
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4B39EF)),
//                           // Add this line to change the background color on hover
//                           overlayColor: MaterialStateProperty.all<Color>(const Color(0xFF4B39EF)),
//                         ),
//                         child: const Text('Upload Image'),
//                       )

//                     ],
//                   ),
//                 ),

//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       'Training Title',
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                 ),

//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
//                   child: Theme(
//                     data: Theme.of(context).copyWith(
//                       inputDecorationTheme: InputDecorationTheme(

//                         //labelText: 'Training Title',
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.accent3,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.primary,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.error,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.error,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         filled: true,
//                         contentPadding:
//                         const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
//                       ),
//                     ),
//                     child: GTextFormField(decoration: null,
//                       maxLines: 1,
//                       initVal: widget.training.title,
//                       ifEmpty: "Category name is required",
//                       onSaved: (value) => title = value!,
//                       hint: "Training Title",
//                     ),
//                   ),
//                 ),


//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       'Training Author',
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                 ),

//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
//                   child: Theme(
//                     data: Theme.of(context).copyWith(
//                       inputDecorationTheme: InputDecorationTheme(

//                         //labelText: 'Training Title',
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.accent3,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.primary,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.error,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.error,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         filled: true,
//                         contentPadding:
//                         const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
//                       ),
//                     ),
//                     child: GTextFormField(decoration: null,
//                         maxLines: 1,
//                         initVal: widget.training.author,
//                         ifEmpty: "Please enter Training author name",
//                         onSaved: (value) => author = value!,
//                         hint: "Author"),
//                   ),
//                 ),

//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       'Training Duration',
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                 ),

//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
//                   child: Theme(
//                     data: Theme.of(context).copyWith(
//                       inputDecorationTheme: InputDecorationTheme(

//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.accent3,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.primary,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.error,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.error,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         filled: true,
//                         contentPadding:
//                         const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
//                       ),
//                     ),
//                     child: GTextFormField(decoration: null,
//                         maxLines: 1,
//                         initVal: widget.training.duration,
//                         ifEmpty: "Please Enter duration & Specify the duration unit ( Months / Days / Hours )",
//                         onSaved: (value) => duration = value!,
//                         hint: "Duration - Specify the duration unit (Months/Days/Hours)"),
//                   ),
//                 ),


//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       'Training Price (TND)',
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                 ),


//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
//                   child: Theme(
//                     data: Theme.of(context).copyWith(
//                       inputDecorationTheme: InputDecorationTheme(

//                         //labelText: 'Training Title',
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.accent3,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.primary,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.error,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.error,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         filled: true,
//                         contentPadding:
//                         const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
//                       ),
//                     ),
//                     child: GTextFormField(decoration: null,
//                         maxLines: 1,
//                         initVal: widget.training.price.toString(),
//                         ifEmpty: "Please enter a number value for the training price",
//                         onSaved: (value) => price = value!,
//                         hint: "Training Price (TND)"),
//                   ),
//                 ),

//                 /* Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
//                   child: FFDropDown<String>(
//                     //bordercolor: MyColors.accent3,
//                    // controller: _model.categoriesStateValueController ??=
//                      //   FormFieldController<String>(
//                        //   _model.categoriesStateValue ??= 'Admin option 1',
//                         //),
//                     options: ['Admin option 1', 'Option 2 '],
//                     onChanged: (val) =>
//                         setState(() => null),
//                     width: double.infinity,
//                     height: 56.0,
//                    // textStyle: FFTheme.of(context).bodyMedium,
//                     hintText: 'Select Categories',
//                     icon: const Icon(
//                       Icons.keyboard_arrow_down_rounded,
//                       color: MyColors.secondaryText,
//                       size: 15.0,
//                     ),
//                     //fillcolor: MyColors.secondaryBackground,
//                     elevation: 2.0,
//                     //bordercolor: MyColors.accent3,
//                     borderWidth: 2.0,
//                     borderRadius: 8.0,
//                     margin: const EdgeInsetsDirectional.fromSTEB(20.0, 4.0, 12.0, 4.0),
//                     hidesUnderline: true,
//                     isSearchable: true,
//                   ),
//                 ),*/

//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       'Training Categories & Tags',
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                 ),


//                 const SizedBox(height: 16,),


//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [

//                       const SizedBox(width: 20,),

//                       Padding(
//                         padding:
//                         const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
//                         child: Image.network(
//                           'https://cdn-icons-png.flaticon.com/512/10548/10548838.png',
//                           width: 35.0,
//                           height: 35.0,
//                           fit: BoxFit.cover,
//                         ),
//                       ),


//                       ElevatedButton(
//                         onPressed: _showMultiSelect,
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4B39EF)),
//                           // Add this line to change the background color on hover
//                           overlayColor: MaterialStateProperty.all<Color>(const Color(0xFF4B39EF)),
//                         ),
//                         child: const Text('Select Categories'),
//                       ),

//                       const SizedBox(width: 20,),

//                       Wrap(
//                         children: _selectedCategories!.map((e) => Chip(label: Text(e),backgroundColor: MyColors.secondary,))
//                             .toList(),),


//                     ],
//                   ),
//                 ),



//                 const SizedBox(height: 16,),



//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,

//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Row(
//                       children: [
//                         const SizedBox(width: 20,),

//                         Padding(
//                           padding:
//                           const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
//                           child: Image.network(
//                             'https://cdn-icons-png.flaticon.com/512/7915/7915521.png',
//                             width: 35.0,
//                             height: 35.0,
//                             fit: BoxFit.cover,
//                           ),
//                         ),

//                         ElevatedButton(
//                           onPressed: _showMultiSelect_,
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4B39EF)),
//                             // Add this line to change the background color on hover
//                             overlayColor: MaterialStateProperty.all<Color>(const Color(0xFF4B39EF)),
//                           ),
//                           child: const Text('Select Tags'),
//                         ),

//                         const SizedBox(width: 20,),


//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Wrap(
//                             children: _selectedTags!
//                                 .map((e) => Chip(label: Text(e),backgroundColor: MyColors.alternate, ))
//                                 .toList(),
//                           ),
//                         ),


//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 16,),




// /*
//                 InkWell(
//                   splashColor: Colors.transparent,
//                   focusColor: Colors.transparent,
//                   hoverColor: Colors.transparent,
//                   highlightColor: Colors.transparent,
//                   onTap: () async {
//                     //context.pushNamed('HomePage');
//                   },
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                     const Text(
//                     'Select your tags',
//                      */
// /*style: FFTheme.of(context).bodyMedium.override(
//                     fontFamily: 'Poppins',
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.normal,
//                   ),*//*

//                 ),
//                 IconButton(
//                */
// /*   borderColor: Colors.transparent,
//                   borderRadius: 30.0,
//                   borderWidth: 1.0,
//                   buttonSize: 60.0,*//*

//                   icon: const FaIcon(
//                     FontAwesomeIcons.tags,
//                     color: MyColors.secondary,
//                     size: 30.0,
//                   ),
//                   onPressed: () {
//                     print('IconButton pressed ...');
//                   },
//                 ),
//                IconButton(
//                  */
// /* borderColor: Colors.transparent,
//                   borderRadius: 30.0,
//                   borderWidth: 1.0,
//                   buttonSize: 60.0,*//*

//                   icon: const FaIcon(
//                     FontAwesomeIcons.tags,
//                     color: MyColors.primaryText,
//                     size: 30.0,
//                   ),
//                   onPressed: () {
//                     print('IconButton pressed ...');
//                   },
//                 ),
//               ],
//             ),
//         ),
// */


//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       'Training Video - Add Youtube Link',
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                 ),

//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [

//                       Padding(
//                         padding:
//                         const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
//                         child: Image.network(
//                           'https://cdn-icons-png.flaticon.com/512/174/174883.png',
//                           width: 35.0,
//                           height: 35.0,
//                           fit: BoxFit.cover,
//                         ),
//                       ),



//                       /* Padding(
//               padding:
//               const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
//               child: Image.network(
//                 'https://cdn-icons-png.flaticon.com/512/2504/2504719.png',
//                 width: 35.0,
//                 height: 35.0,
//                 fit: BoxFit.cover,
//               ),
//             ),
// */


//                       /*
//             Padding(
//                   padding:
//                   const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
//                   child: Image.network(
//                     'https://cdn-icons-png.flaticon.com/512/7471/7471685.png',
//                     width: 35.0,
//                     height: 35.0,
//                     fit: BoxFit.cover,
//                   ),
//                 ),

//                 */



//                       Expanded(
//                         child:

//                         Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
//                           child: Theme(
//                             data: Theme.of(context).copyWith(
//                               inputDecorationTheme: InputDecorationTheme(

//                                 //labelText: 'Training Title',
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                     color: MyColors.accent3,
//                                     width: 2.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                     color: MyColors.primary,
//                                     width: 2.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                     color: MyColors.error,
//                                     width: 2.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                     color: MyColors.error,
//                                     width: 2.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                                 filled: true,
//                                 contentPadding:
//                                 const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
//                               ),
//                             ),
//                             child: GTextFormField( decoration: null,
//                                 maxLines: 1,
//                                 initVal: widget.training.trailerVid,
//                                 ifEmpty: "Please enter The Trailer video URL",
//                                 onSaved: (value) => trailerVid = value!,
//                                 hint: "Trailer Video URL"),
//                           ),
//                         )

//                         ,
//                       ),
//                     ],
//                   ),
//                 ),

//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       'Training Description',
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                 ),


//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
//                   child: Theme(
//                     data: Theme.of(context).copyWith(
//                       inputDecorationTheme: InputDecorationTheme(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.accent3,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.primary,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.error,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: MyColors.error,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         filled: true,
//                         fillColor: MyColors.accent4,
//                         contentPadding:
//                         const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
//                       ),
//                     ),
//                     child: SizedBox(
//                       height: 150.0,
//                       child: GTextFormField(
//                         initVal: widget.training.description,
//                         ifEmpty: "Please enter Training description",
//                         onSaved: (value) => description = value!,
//                         hint: "Training Description",
//                         maxLines: 10,
//                         decoration: null,
//                       ),
//                     ),
//                   ),
//                 ),

// /*
//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
//                   child: SizedBox(
//                     height: 150.0,
//                     child: GTextFormField(
//                       initVal: widget.training.description,
//                       ifEmpty: "Please enter Training description",
//                       onSaved: (value) => description = value!,
//                       hint: "Training Description",
//                       maxLines: 8,
//                       decoration: null,

//                       //textAlign: TextAlign.start,
//                     ),
//                   ),
//                 ),
// */

//                 Align(
//                   alignment: const AlignmentDirectional(0.0, 0.05),
//                   child: Padding(
//                     padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 20.0),

//                     child: ElevatedButton(
//                       onPressed: ()  async {
//                         if (_formKey.currentState!.validate()) {
//                           _formKey.currentState!.save();
//                           await trainingProvider.updateTraining(
//                               Training(
//                                   title: title,
//                                   description: description,
//                                   category: _selectedCategories!,
//                                   author: author,
//                                   duration: duration,
//                                   price: double.parse(price),
//                                   trailerVid: trailerVid,
//                                   image: imageUrl,
//                                   tags: _selectedTags,
//                                   creationDate: Timestamp.now()),

//                               widget.training.id!);
//                           Navigator.pop(context);
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: const Size(200.0, 60.0),
//                         primary: const Color(0xFF4B39EF),
//                         elevation: 2.0,
//                         side: const BorderSide(
//                           color: Colors.transparent,
//                           width: 1.0,
//                         ),
//                       ),
//                       child: const Text(
//                         'Save Changes',
//                         style: TextStyle(
//                           fontSize: 14.0,
//                         ),
//                       ),
//                     ),

//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
