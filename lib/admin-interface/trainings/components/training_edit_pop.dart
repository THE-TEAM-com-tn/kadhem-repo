import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect/multiselect.dart';
import 'package:theteam_gyp/admin-interface/models/category_model.dart';
import 'package:theteam_gyp/admin-interface/models/tag_model.dart';
import 'package:theteam_gyp/admin-interface/trainings/trainings_controller.dart';
import 'package:theteam_gyp/admin-interface/trainings/widgets/G_text_form_field.dart';
import 'package:theteam_gyp/core/models/training_model.dart';

class TrainingEditPop extends StatefulWidget {
  final TrainingModel training;

  const TrainingEditPop({super.key, required this.training});

  @override
  TrainingEditPopState createState() => TrainingEditPopState();
}

class TrainingEditPopState extends State<TrainingEditPop> {
  final _formKey = GlobalKey<FormState>();

  TrainingsController controller = TrainingsController();

  List<String> selectedCategories = [];
  List<String> selectedTags = [];

  late String imageUrl;

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
        final image = await referenceImgToUpload.getDownloadURL();
        setState(() {
          imageUrl = image;
        });
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
        imageUrl = await referenceImgToUpload.getDownloadURL();
        print("##### Image URL: $imageUrl");
      } catch (error) {
        print("#####ERROR: $error");
      }
    }
  }

  late String title;
  late String description;
  late String author;
  late String duration;
  late String price;
  late String trailerVid;

  @override
  void initState() {
    super.initState();

    selectedCategories = widget.training.categories;
    selectedTags = widget.training.tags!;
    imageUrl = widget.training.image;
  }

  @override
  Widget build(BuildContext context) {
    // return Placeholder();
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
                  Container(
                      width: 90.0,
                      height: 90.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.fitWidth,
                      )),
                  ElevatedButton(
                    onPressed: _selectImage,
                    child: const Text('Select Training Image'),
                  ),
                  GTextFormField(
                      decoration: null,
                      maxLines: 1,
                      initVal: widget.training.title,
                      ifEmpty: "Category name is required",
                      onSaved: (value) => title = value!,
                      hint: "Training Title"),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                      decoration: null,
                      maxLines: 1,
                      initVal: widget.training.description,
                      ifEmpty: "Please enter Training description",
                      onSaved: (value) => description = value!,
                      hint: "Description"),
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
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                      decoration: null,
                      maxLines: 1,
                      initVal: widget.training.author,
                      ifEmpty: "Please enter Training author name",
                      onSaved: (value) => author = value!,
                      hint: "Author"),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                      decoration: null,
                      maxLines: 1,
                      initVal: widget.training.duration,
                      ifEmpty: "Please enter Training duration",
                      onSaved: (value) => duration = value!,
                      hint: "Duration"),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                      decoration: null,
                      maxLines: 1,
                      initVal: widget.training.price.toString(),
                      ifEmpty: "Please enter Training price",
                      onSaved: (value) => price = value!,
                      hint: "Price"),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                      decoration: null,
                      maxLines: 1,
                      initVal: widget.training.trailerVid,
                      ifEmpty: "Please enter The Trailer video URL",
                      onSaved: (value) => trailerVid = value!,
                      hint: "Trailer Video URL"),
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
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await controller.updateTraining(
                            TrainingModel(
                                    title: title,
                                    description: description,
                                    categories: selectedCategories!,
                                    author: author,
                                    duration: duration,
                                    price: double.parse(price),
                                    trailerVid: trailerVid,
                                    image: imageUrl,
                                    tags: selectedTags,
                                    creationDate: Timestamp.now())
                                .toJson(),
                            widget.training.id!);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Update',
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
