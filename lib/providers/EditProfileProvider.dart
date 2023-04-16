import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearning_provider/models/UserModel.dart';
import 'package:elearning_provider/services/EditProfileService.dart';
import 'package:flutter/material.dart';

import '../locator.dart';

class EditProfileProvider with ChangeNotifier {
  final EditProfileService _api = locator<EditProfileService>();
  DocumentSnapshot? _documentSnapshot;
  bool loading = true ; 
  bool imageUpdating = false ; 

  updateData(UserModel userModel) async {
   bool result =  await _api.updateData(userModel);
    loading  = true ;
    notifyListeners();
    return result ; 
  }

  defaultImage(String? doc) {
    _api.defaultImage(doc!) ; 
    loading = true ; 
    notifyListeners(); 
  }

  updateImage(String name, Uint8List bytes) async {
    imageUpdating = true; 
    notifyListeners(); 
    await _api.updateImage(name, bytes);
    loading = true;
    imageUpdating = false ;
    notifyListeners();
  }

  fetchData(String? docId) async {
    _documentSnapshot = await _api.fetchData(docId!);
    final Map<String, dynamic> doc =
    _documentSnapshot!.data() as Map<String, dynamic>;
    userModel.userId = docId;
    userModel.firstname = doc['firstName'] ?? '';
    userModel.lastname = doc['lastName'] ?? '';
    userModel.email = doc['email'] ?? '';
    userModel.address = doc['address'] ?? '';
    userModel.phoneNumber = doc['phone_number'] ?? '';
    userModel.profilePicture = doc['profile_picture'] ?? '';
    userModel.bio = doc['bio'] ?? '';
    userModel.birthDate = doc['birth_date'] ?? '';
    userModel.company = doc['company'] ?? '';
    userModel.role = doc['role'] ?? '';
    userModel.password = doc['password'] ?? '';
    loading = false ; 
    notifyListeners();
  }

  DocumentSnapshot? get documentSnapshot => _documentSnapshot;
}
