// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../models/training_model.dart';
import '../../../providers/training_crud_model.dart';
import '../../Widgets/G_text_form_field.dart';
import '../../Widgets/multi_select_tags_tool.dart';
import '../../Widgets/multi_select_tool_categroy.dart';

class ModifyTraining extends StatefulWidget {
  final Training training;

  const ModifyTraining({super.key, required this.training});

  @override
  ModifyTrainingState createState() => ModifyTrainingState();
}

class ModifyTrainingState extends State<ModifyTraining> {
  final _formKey = GlobalKey<FormState>();

  List<String> _selectedCategories = [];
  List<String> _selectedTags = [];
  String imageUrl = "";

  void _showMultiSelect() async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MultiSelect();
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedCategories = results;
      });
    }
  }

  void _showMultiSelect_() async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MultiSelectTags();
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedTags = results;
      });
    }
    print("##### $_selectedTags");
  }

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
  Widget build(BuildContext context) {
    final trainingProvider = Provider.of<TrainingCRUDModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Modify Training Details'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              GTextFormField(
                  initVal: widget.training.title,
                  ifEmpty: "Category name is required",
                  onSaved: (value) => title = value!,
                  hint: "Training Title"),
              const SizedBox(
                height: 16,
              ),
              GTextFormField(
                  initVal: widget.training.description,
                  ifEmpty: "Please enter Training description",
                  onSaved: (value) => description = value!,
                  hint: "Description"),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: _showMultiSelect,
                child: const Text('Select Categories'),
              ),
              Wrap(
                children: _selectedCategories
                    .map((e) => Chip(label: Text(e)))
                    .toList(),
              ),
              const SizedBox(
                height: 16,
              ),
              GTextFormField(
                  initVal: widget.training.author,
                  ifEmpty: "Please enter Training author name",
                  onSaved: (value) => author = value!,
                  hint: "Author"),
              const SizedBox(
                height: 16,
              ),
              GTextFormField(
                  initVal: widget.training.duration,
                  ifEmpty: "Please enter Training duration",
                  onSaved: (value) => duration = value!,
                  hint: "Duration"),
              const SizedBox(
                height: 16,
              ),
              GTextFormField(
                  initVal: widget.training.price.toString(),
                  ifEmpty: "Please enter Training price",
                  onSaved: (value) => price = value!,
                  hint: "Price"),
              const SizedBox(
                height: 16,
              ),
              GTextFormField(
                  initVal: widget.training.trailerVid,
                  ifEmpty: "Please enter The Trailer video URL",
                  onSaved: (value) => trailerVid = value!,
                  hint: "Trailer Video URL"),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: _selectImage,
                child: const Text('Select Training Image'),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                // splashColor: Colors.red,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await trainingProvider.updateTraining(
                        Training(
                            title: title,
                            description: description,
                            category: _selectedCategories,
                            author: author,
                            duration: duration,
                            price: double.parse(price),
                            trailerVid: trailerVid,
                            image: imageUrl,
                            tags: _selectedTags,
                            creationDate: Timestamp.now()),
                        widget.training.id!);
                    Navigator.pop(context);
                  }
                },
                child: const Text('update Training',
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
