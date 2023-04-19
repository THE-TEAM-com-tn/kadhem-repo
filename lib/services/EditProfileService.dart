/*
// ignore_for_file: file_names

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

import '../models/UserModel.dart';

class EditProfileService {
  final _db = FirebaseFirestore.instance;
  int count = 0;
  late CollectionReference ref;

  EditProfileService() {
    ref = _db.collection("Users");
  }

  Future<bool> updateData(UserModel userModel) async {
    if (await checkEmail(userModel.userId)) {
      // check the email before updating
      ref.doc(userModel.userId).update(userModel.toJson());
      return true;
    }
    return false;
  }

  Future<bool> checkEmail(String? currentUser) async {
    var query = await _db.collection("Users").doc(currentUser).get();
    // verify if the user has modified his email
    if (query['email'] == userModel.email) {
      return true;
    }
    // If he did Modify his email, check if it exists
    else {
      QuerySnapshot querySnapshot =
          await _db.collection("Users").get(); // get all documents
      for (var element in querySnapshot.docs) {
        if (element['email'] == userModel.email) {
          // check if there is someone with the same modified email
          return false;
        }
      }
      return true;
    }
  }

  fetchData(String? docId) async {
    return ref.doc(docId).get();
  }

  defaultImage(String doc) async {
    await _db.collection('Users').doc(doc).update({
      "profile_picture": "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
    });
  }

  updateImage(String name, Uint8List? bytes) async {
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    await storage.ref("TestFolder/$name").putData(bytes!);
    var imageRef = storage.ref('TestFolder/$name');
    await imageRef.getDownloadURL().then((url) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userModel.userId)
          .update({"profile_picture": url});
    });
  }

  delteImage() async {
    await _db.collection('Users').doc(userModel.userId).update({
      "profile_picture": "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
    });
  }
}
*/
