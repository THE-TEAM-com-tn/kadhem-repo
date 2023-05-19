// // ignore_for_file: avoid_print

// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:elearning_provider/UI/Pages/trainings/list_trainings.dart';
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
// import '../../Widgets/nav_bar.dart';


// class AddTraining extends StatefulWidget {
//   const AddTraining({super.key});

//   @override
//   AddTrainingState createState() => AddTrainingState();
// }

// class AddTrainingState extends State<AddTraining> {
//   final _formKey = GlobalKey<FormState>();

//   List<String> _selectedCategories = [];
//   List<String> _selectedTags = [];
//   String imageUrl = "";

//   late String title;
//   late String description;
//   late String author;
//   late String duration;
//   late double price;
//   late String trailerVid;

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
//         imageUrl = await referenceImgToUpload.getDownloadURL();
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
//         final image = await referenceImgToUpload.getDownloadURL();
//         setState(() {
//           imageUrl = image ; 
        
//         });
//       print("##### Image URL: $imageUrl");
//       } catch (error) {
//         print("#####ERROR: $error");
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var trainingProvider = Provider.of<TrainingCRUDModel>(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple[200],
//         elevation: 0,
//         title: const Center(
//           child: Text('Add Training '),
//         ),
//       ),


//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//              imageUrl != "" ? Container(
//                   width: 90.0,
//                   height: 90.0,
//                   clipBehavior: Clip.antiAlias,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                   ),
//                   child: Image.network(
//                     imageUrl,
//                     fit: BoxFit.fitWidth,
//                   )) : SizedBox(),
//               ElevatedButton(
//                 onPressed: _selectImage,
//                 child: const Text('Select Training Image'),
//               ),
//               GTextFormField(
//                 initVal: null,
//                   decoration: null,
//                   maxLines: 1,
//                   ifEmpty: "Training title is required",
//                   onSaved: (value) => title = value!,
//                   hint: "Training Title"),
//               const SizedBox(
//                 height: 16,
//               ),
//               GTextFormField(
//                 initVal: null,
//                   decoration: null,
//                   maxLines: 1,
//                   ifEmpty: "Training description is required",
//                   onSaved: (value) => description = value!,
//                   hint: "Training description"),
//               const SizedBox(
//                 height: 16,
//               ),
//               ElevatedButton(
//                   onPressed: _showMultiSelect,
//                   child: const Text('Select Categories')),
//               const SizedBox(
//                 height: 16,
//               ),
//               // display selected items
//               Wrap(
//                 children: _selectedCategories
//                     .map((e) => Chip(label: Text(e)))
//                     .toList(),
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               GTextFormField(
//                   decoration: null,
//                   maxLines: 1,
//                   ifEmpty: "Training author name is required",
//                   onSaved: (value) => author = value!,
//                   hint: "Training Author Name", initVal: null,),
//               const SizedBox(
//                 height: 16,
//               ),
//               GTextFormField(
//                   decoration: null,
//                   maxLines: 1,
//                   ifEmpty: "Training duration is required",
//                   onSaved: (value) => duration = value!,
//                   hint: "Training Duration, Please Specify in Months/Weeks/Days/Hours...", initVal: null,),
//               const SizedBox(
//                 height: 16,
//               ),
//               GTextFormField(
//                   initVal: null,
//                   decoration: null,
//                   maxLines: 1,
//                   ifEmpty: "Training price is required",
//                   onSaved: (value) => price = double.parse(value!),
//                   hint: "Training Price"),
//               const SizedBox(
//                 height: 16,
//               ),
//               GTextFormField(
//                   initVal: null,
//                   decoration: null,
//                   maxLines: 1,
//                   ifEmpty: "Training trailer video URL is required",
//                   onSaved: (value) => trailerVid = value!,
//                   hint: "Training Trailer Video URL"),
//               const SizedBox(
//                 height: 16,
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               ElevatedButton(
//                 onPressed: _showMultiSelect_,
//                 child: const Text('Select Tags'),
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               // display selected items
//               Wrap(
//                 children: _selectedTags
//                     .map((e) => Chip(
//                           label: Text(e),
//                         ))
//                     .toList(),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               ElevatedButton(
//                 // splashColor: Colors.red,
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     await trainingProvider.addTraining(Training(
//                         title: title,
//                         description: description,
//                         category: _selectedCategories,
//                         author: author,
//                         duration: duration,
//                         price: price,
//                         trailerVid: trailerVid,
//                         image: imageUrl,
//                         tags: _selectedTags,
//                         creationDate: Timestamp.now()));
//                         Navigator.pop(context) ;
//                   }
//                 },
//                 child: const Text('add Training',
//                     style: TextStyle(color: Colors.white)),
//                 // color: Colors.blue,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
