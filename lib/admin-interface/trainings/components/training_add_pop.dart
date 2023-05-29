import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect/multiselect.dart';
import 'package:theteam_gyp/admin-interface/models/category_model.dart';
import 'package:theteam_gyp/admin-interface/models/tag_model.dart';
import 'package:theteam_gyp/admin-interface/trainings/widgets/G_text_form_field.dart';
import 'package:theteam_gyp/admin-interface/trainings/trainings_controller.dart';
import 'package:theteam_gyp/core/models/training_model.dart';

class TrainingAddPop extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrainingAddPopState();
  }
}

class _TrainingAddPopState extends State<TrainingAddPop> {
  final _formKey = GlobalKey<FormState>();

  String imageUrl = "";

  late String title;
  late String description;
  late String author;
  late String duration;
  late double price;
  late String trailerVid;

  TrainingsController controller = TrainingsController();

  List<String> selectedCategories = [];
  List<String> selectedTags = [];

  void _selectImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (!kIsWeb) {
      print("##### Mobile Detetcted!");

      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      print("##### Image unique name: $uniqueFileName");

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImg = referenceRoot.child("images");
      Reference referenceImgToUpload = referenceDirImg.child(uniqueFileName);

      try {
        await referenceImgToUpload.putFile(File(file!.path));
        imageUrl = await referenceImgToUpload.getDownloadURL();
        print("##### Image URL: $imageUrl");
      } catch (error) {
        print("#####ERROR: $error");
      }
    } else if (kIsWeb) {
      print("##### Web Detetcted!");

      var imageBytes = await file?.readAsBytes();

      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      print("##### Image unique name: $uniqueFileName");

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImg = referenceRoot.child("images");
      Reference referenceImgToUpload = referenceDirImg.child(uniqueFileName);

      try {
        await referenceImgToUpload.putData(imageBytes!);
        final image = await referenceImgToUpload.getDownloadURL();
        imageUrl = image;
        print("##### Image URL: $imageUrl");
      } catch (error) {
        print("#####ERROR: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 2,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  imageUrl != ""
                      ? Container(
                          width: 90.0,
                          height: 90.0,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.fitWidth,
                          ))
                      : SizedBox(),
                  ElevatedButton(
                    onPressed: _selectImage,
                    child: const Text('Select Training Image'),
                  ),
                  GTextFormField(
                      initVal: null,
                      decoration: null,
                      maxLines: 1,
                      ifEmpty: "Training title is required",
                      onSaved: (value) => title = value!,
                      hint: "Training Title"),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                      initVal: null,
                      decoration: null,
                      maxLines: 1,
                      ifEmpty: "Training description is required",
                      onSaved: (value) => description = value!,
                      hint: "Training description"),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder(
                      future: controller.getAvailableCategories(),
                      builder: (context,
                          AsyncSnapshot<List<CategoryModel>> snapshot) {
                        List<String> _dropdownItems =
                            snapshot.data!.map((item) {
                          return item.name.toString();
                        }).toList();
                        return DropDownMultiSelect(
                          selectedValues: selectedCategories,
                          options: _dropdownItems,
                          onChanged: (selectedItems) {
                            setState(() {
                              selectedCategories = selectedItems;
                            });
                          },
                          hint: const Text('Select categories'),
                        );
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                    decoration: null,
                    maxLines: 1,
                    ifEmpty: "Training author name is required",
                    onSaved: (value) => author = value!,
                    hint: "Training Author Name",
                    initVal: null,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                    decoration: null,
                    maxLines: 1,
                    ifEmpty: "Training duration is required",
                    onSaved: (value) => duration = value!,
                    hint:
                        "Training Duration, Please Specify in Months/Weeks/Days/Hours...",
                    initVal: null,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                      initVal: null,
                      decoration: null,
                      maxLines: 1,
                      ifEmpty: "Training price is required",
                      onSaved: (value) => price = double.parse(value!),
                      hint: "Training Price"),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                      initVal: null,
                      decoration: null,
                      maxLines: 1,
                      ifEmpty: "Training trailer video URL is required",
                      onSaved: (value) => trailerVid = value!,
                      hint: "Training Trailer Video URL"),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder(
                      future: controller.getAvailableTags(),
                      builder:
                          (context, AsyncSnapshot<List<TagModel>> snapshot) {
                        List<String> _dropdownItems =
                            snapshot.data!.map((item) {
                          return item.label.toString();
                        }).toList();
                        return DropDownMultiSelect(
                          selectedValues: selectedTags,
                          options: _dropdownItems,
                          onChanged: (selectedItems) {
                            setState(() {
                              selectedTags = selectedItems;
                            });
                          },
                          hint: const Text('Select tags'),
                        );
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await controller.addDocToCol(
                            TrainingModel(
                                    title: title,
                                    description: description,
                                    categories: selectedCategories,
                                    author: author,
                                    duration: duration,
                                    price: price,
                                    trailerVid: trailerVid,
                                    image: imageUrl,
                                    tags: selectedTags,
                                    creationDate: Timestamp.now())
                                .toJson(),
                            "trainings");
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add',
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
