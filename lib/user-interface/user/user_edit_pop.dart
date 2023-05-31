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
import 'package:theteam_gyp/core/models/profile_model.dart';
import 'package:theteam_gyp/core/models/training_model.dart';
import 'package:theteam_gyp/core/users_controller.dart';

class UserEditPop extends StatefulWidget {
  final ProfileModel profil;

  const UserEditPop({super.key, required this.profil});

  @override
  UserEditPopState createState() => UserEditPopState();
}

class UserEditPopState extends State<UserEditPop> {
  final _formKey = GlobalKey<FormState>();

  UsersController controller = UsersController();

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

  late String name;
  late String email;
  late String phone;
  late String company;
  late String address;
  late String bio;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.profil.photo;
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
                      initVal: widget.profil.name,
                      ifEmpty: "Name is required",
                      onSaved: (value) => name = value!,
                      hint: "Name"),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                      decoration: null,
                      maxLines: 1,
                      initVal: widget.profil.email,
                      ifEmpty: "Please enter your email",
                      onSaved: (value) => email = value!,
                      hint: "Email"),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                      decoration: null,
                      maxLines: 1,
                      initVal: widget.profil.phone,
                      ifEmpty: "Please enter you phone number",
                      onSaved: (value) => phone = value!,
                      hint: "Phone"),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                      decoration: null,
                      maxLines: 1,
                      initVal: widget.profil.company,
                      ifEmpty: "Please enter your company",
                      onSaved: (value) => company = value!,
                      hint: "Company"),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                      decoration: null,
                      maxLines: 1,
                      initVal: widget.profil.address,
                      ifEmpty: "Please enter your address",
                      onSaved: (value) => address = value!,
                      hint: "Address"),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                      decoration: null,
                      maxLines: 1,
                      initVal: widget.profil.bio,
                      ifEmpty: "Please enter your bio",
                      onSaved: (value) => bio = value!,
                      hint: "Bio"),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await controller.updateUser(
                            ProfileModel(
                              name: name,
                              email: email,
                              photo: imageUrl,
                              company: company,
                              address: address,
                              bio: bio,
                            ).toJson(),
                            widget.profil.id!);
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
